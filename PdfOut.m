#import "PdfOut.h"

@implementation PdfOut
@synthesize pdf;
- (id)init
{
	if (self = [super init]) {
		struct pdf_info info = {
			.creator	= "Gnutello",
			.producer	= "Gnustep",
			.title		= "Minimax tree",
			.author		= "Gnutello",
			.subject	= "trying to display the best path from a minimax tree",
			.date		= "Today"
		};

		pdf = pdf_create(PDF_A4_WIDTH, PDF_A4_HEIGHT, &info);
		pdf_set_font(pdf, "Times-Roman");
		pdf_append_page(pdf);
		pdf_add_text(pdf, NULL, "This is text", 12, 0, PDF_A4_HEIGHT - 12, PDF_BLACK);
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"deallocating PdfOut at %p", self);
	pdf_destroy(pdf);
	[super dealloc];
}

- (void)save:(NSString *)filename
{
	pdf_save(pdf, [filename cString]);
}

- (void)drawStroke:(Stroke *)stroke atX:(float)atx andY:(float)aty;
{
	float x1, y1, x2, y2;
	float multiplier = .08f;

	for (int i = 0; i <= 8; i++) {
		x1 = atx;
		x2 = atx + 8 * 6 * multiplier;
		y1 = aty + i * 6 * multiplier;
		y2 = aty + i * 6 * multiplier;
		pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f * multiplier, PDF_BLACK);

		x1 = atx + i * 6 * multiplier;
		x2 = atx + i * 6 * multiplier;
		y1 = aty;
		y2 = aty + 8 * 6 * multiplier;
		pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f * multiplier, PDF_BLACK);
	}

	for (int y = 0; y < 8; y++) {
		for (int x = 0; x < 8; x++) {
			if ([stroke board][INDEX(x, y)] == WHITE) {
				pdf_add_circle(pdf, NULL, (x + 1) * 6 * multiplier + atx - 3 * multiplier, ((7 - y) + 1) * 6 * multiplier + aty - 3 * multiplier, 2.0f * multiplier, 1.0f * multiplier, PDF_BLACK, PDF_WHITE);
			}
			else if ([stroke board][INDEX(x, y)] == BLACK) {
				pdf_add_circle(pdf, NULL, (x + 1) * 6 * multiplier + atx - 3 * multiplier, ((7 - y) + 1) * 6 * multiplier + aty - 3 * multiplier, 2.0f * multiplier, 1.0f * multiplier, PDF_BLACK, PDF_BLACK);
			}
			else {
				// Empty
			}
		}
	}
}

/*
 * 105 105
 *       protected static void CalculatePositions(TreeNode<T> node, float startRadians, float endRadians, float circleRadius, float radialIncrement)
 *       {
 *           float theta = startRadians;
 *           int leavesNumber = BreadthFirstSearch(node);
 *
 *           foreach (var child in node.Children)
 *           {
 *               float lambda = BreadthFirstSearch(child);
 *               float mi = theta + ((lambda / leavesNumber) * (endRadians - startRadians));
 *
 *               float x = (float)(circleRadius * Math.Cos((theta + mi) / 2.0));
 *               float y = (float)(circleRadius * Math.Sin((theta + mi) / 2.0));
 *
 *               child.Point.X = x;
 *               child.Point.Y = y;
 *
 *               if (child.Children.Count > 0)
 *               {
 *                   // RECURSIVE CALL
 *                   CalculatePositions(child, theta, mi, circleRadius + radialIncrement, radialIncrement);
 *               }
 *
 *               theta = mi;
 *           }
 *       }
 */

- (void)computeTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta withCircleRadius:(double)circleRadius withRadialIncrement:(double)radialIncrement withDic:(NSMutableDictionary *)positions
{
/* Given a rooted tree T, a vertex v ∈ V (T), and the angles α and β
 *  that define v’s annulus wedge, the algorithm calculates the position of every
 *  child vertex c of v in a new graph drawing Γ. R0 is the user-defined radius
 *  of the innermost concentric circle. ξ is the user-defined delta angle constant
 *  for the drawing’s concentric circles. The initial values for α and β for the
 *  root’s annulus wedge are 0° and 360°, respectively */

	NSLog(@"DEPTH %d", [root depth]);

	if ([root depth] == 1) {
		// root
		NSLog(@"root");
		NSMutableDictionary *radialPosition = [NSMutableDictionary new];
		[radialPosition setObject:[NSNumber numberWithDouble:0] forKey:@"x"];
		[radialPosition setObject:[NSNumber numberWithDouble:0] forKey:@"y"];
		[radialPosition setObject:[NSNumber numberWithDouble:0] forKey:@"radius"];
		[radialPosition setObject:[NSNull null] forKey:@"parent"];
		[radialPosition setObject:root forKey:@"node"];
        [radialPosition setObject:[root strValue] forKey:@"title"];
		NSValue *objectKey = [NSValue valueWithNonretainedObject:root];
		[positions setObject:radialPosition forKey:objectKey];
		[radialPosition release];
	}

	int depthOfVertex = [root depth];
	double theta = alfa;
	NSMutableDictionary *dic = [NSMutableDictionary new];

	[dic setValue:[NSNumber numberWithInt:0] forKey:@"value"];
	[Tree preOrderTraversal:root withSelector:@"countLeaves:withCounter:" andObject:dic];
	int leavesNumber = [[dic valueForKey:@"value"] intValue];

	[dic release];

	for (int i = 0; i < [[root children] count]; i++) {
		TreeNode *child = [[root children] objectAtIndex:i];
		NSMutableDictionary *dic = [NSMutableDictionary new];
		[dic setValue:[NSNumber numberWithInt:0] forKey:@"value"];
		[Tree preOrderTraversal:child withSelector:@"countLeaves:withCounter:" andObject:dic];
		int lambda = [[dic valueForKey:@"value"] intValue];
		[dic release];
		double mi = theta + (((double)lambda / leavesNumber) * (beta - alfa));
		double x = (circleRadius * cos((theta + mi) / 2.0));
		double y = (circleRadius * sin((theta + mi) / 2.0));

		NSLog(@"leavesNumber=%d  lambda=%d  child.X=%f  child.Y=%f  radius=%f  parent=%@  current=%@", leavesNumber, lambda, x, y, circleRadius, [root strValue], [child strValue]);
		NSMutableDictionary *radialPosition = [NSMutableDictionary new];
		[radialPosition setObject:[NSNumber numberWithDouble:x] forKey:@"x"];
		[radialPosition setObject:[NSNumber numberWithDouble:y] forKey:@"y"];
		[radialPosition setObject:[NSNumber numberWithDouble:circleRadius] forKey:@"radius"];
		[radialPosition setObject:root forKey:@"parent"];
		[radialPosition setObject:child forKey:@"node"];
		[radialPosition setObject:[child strValue] forKey:@"title"];
		NSValue *objectKey = [NSValue valueWithNonretainedObject:child];
		[positions setObject:radialPosition forKey:objectKey];
		[radialPosition release];

		if ([[child children] count] > 0) {
			[self computeTree:child fromAngle:theta toAngle:mi withCircleRadius:(circleRadius + radialIncrement) withRadialIncrement:radialIncrement withDic:positions];
		}
		theta = mi;
	}
}

- (void)drawTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta;
{
	const int START_X = PDF_A4_WIDTH / 2;
	const int START_Y = PDF_A4_HEIGHT / 2;

	NSMutableDictionary *radialPositions = [NSMutableDictionary new];

	[self computeTree:root fromAngle:0 toAngle:2 * M_PI withCircleRadius:RADIUS withRadialIncrement:RADIUS_INCREMENT withDic:radialPositions];

	NSArray *keys = [radialPositions allKeys];

	// Circles
	for (int i = 0; i < [keys count]; i++) {
		id key = [keys objectAtIndex:i];
		NSDictionary *value = [radialPositions objectForKey:key];
		double r = [[value objectForKey:@"radius"] doubleValue];
		pdf_add_circle(pdf, NULL, START_X, START_Y, r, .1, PDF_ARGB(0, 192, 192, 192), PDF_TRANSPARENT);
	}

	// Lines
	for (int i = 0; i < [keys count]; i++) {
		id key = [keys objectAtIndex:i];
		NSDictionary *value = [radialPositions objectForKey:key];
		TreeNode *parent = [value objectForKey:@"parent"];
		double x = [[value objectForKey:@"x"] doubleValue];
		double y = [[value objectForKey:@"y"] doubleValue];

		if (parent != (id)[NSNull null]) {
			NSValue *objectKey = [NSValue valueWithNonretainedObject:parent];
			NSDictionary *valuep = [radialPositions objectForKey:objectKey];
			double xp = [[valuep objectForKey:@"x"] doubleValue];
			double yp = [[valuep objectForKey:@"y"] doubleValue];
			NSLog(@"  -> x=%f y=%f", xp, yp);
			pdf_add_line(pdf, NULL, START_X + x, START_Y + y, START_X + xp, START_Y + yp, .5, PDF_BLACK);
		}
	}

	// Nodes
	for (int i = 0; i < [keys count]; i++) {
		id key = [keys objectAtIndex:i];
		NSDictionary *value = [radialPositions objectForKey:key];
		double x = [[value objectForKey:@"x"] doubleValue];
		double y = [[value objectForKey:@"y"] doubleValue];
		NSString *title = [value objectForKey:@"title"];
		pdf_add_circle(pdf, NULL, START_X + x, START_Y + y, NODE_RADIUS, .2, PDF_RED, PDF_RED);
		pdf_add_text(pdf, NULL, [title cString], FONT_SIZE, START_X + x, START_Y + y, PDF_BLACK);
	}

	[radialPositions removeAllObjects];
	[radialPositions release];
}

@end
