#import "Othello.h"
#import "Stack.h"
#import "Tree.h"
#import "PdfOut.h"
#import <stdint.h>

@implementation Othello
@synthesize stroke;

- (id)init
{
	NSLog(@"Othello init");

	if (self = [super init]) {
		stack = [Stack new];
		stroke = [Stroke new];

		for (int i = 0; i < 8 * 8; i++) {
			[stroke board][i] = EMPTY;
		}

		/*
		 *  [stroke board][INDEX(3, 3)] = BLACK;
		 *  [stroke board][INDEX(4, 3)] = WHITE;
		 *  [stroke board][INDEX(3, 4)] = WHITE;
		 *  [stroke board][INDEX(4, 4)] = BLACK;
		 */

		[stroke board][INDEX(3, 2)] = WHITE;
		[stroke board][INDEX(3, 3)] = WHITE;
		[stroke board][INDEX(4, 3)] = WHITE;
		[stroke board][INDEX(3, 4)] = BLACK;
		[stroke board][INDEX(4, 4)] = BLACK;
	}
	return self;
}

- (id)initWithBoard:(PIECE *)board
{
	if (self = [super init]) {
		stack = [Stack new];
		stroke = [Stroke new];

		for (int i = 0; i < 8 * 8; i++) {
			[stroke board][i] = board[i];
		}
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"Othello dealloc");
	[stack release];
	[stroke release];
	[super dealloc];
}

/* Computer is black */

- (NSArray <Stroke *> *)listStrokes:(Coord)coord withStroke:(Stroke *)strokeCopy andStrokesSet:(NSMutableSet *)similarStrokes;
{
	Coord t;
	NSMutableArray *list = [[NSMutableArray new] autorelease];
	PIECE color = [strokeCopy board][INDEX(coord.x, coord.y)];
	PIECE oppositeColor = (color == WHITE) ? BLACK : WHITE;

	for (int d = 0; d < /*4*/ 8; d++) {
		t = coord;
		bool saveIt = NO;
		bool exploreFromHere = NO;
		Stroke *copyOfTheOriginalStroke = [strokeCopy copy];

		for (int i = 0; i < 8; i++) {
			t.x += allDirections[d].x;
			t.y += allDirections[d].y;

			if (t.x > 7 || t.y > 7 || t.x < 0 || t.y < 0) {
				// frame border
				saveIt = NO;
				break;
			}
			else if ([copyOfTheOriginalStroke board][INDEX(t.x, t.y)] == oppositeColor) {
				// opposite color
				[copyOfTheOriginalStroke board][INDEX(t.x, t.y)] = color;
				saveIt = YES;
				continue;
			}
			else if ([copyOfTheOriginalStroke board][INDEX(t.x, t.y)] == color) {
				// player color
				saveIt = NO;
				break;
			}
			else {
				if (saveIt) {
					exploreFromHere = YES;
					// NSLog(@"break in %d,%d with direction %d,%d - Save:%d", t.x, t.y, allDirections[d].x, allDirections[d].y, saveIt);
				}
				// empty
				break;
			}
		}

		if (saveIt) {
			// //NSLog(@"save dir %d,%d", allDirections[d].x, allDirections[d].y);
			[copyOfTheOriginalStroke board][INDEX(t.x, t.y)] = color;

			// before keeping stroke, explore all directions from new piece to the same color
			// until the same color covering opposite color
			if (exploreFromHere) {
				//NSLog(@"====>");
				Coord c = {t.x, t.y};
				// [Othello logStroke:copyOfTheOriginalStroke];
				Stroke *explored = [self exploreFromHere:c withStroke:copyOfTheOriginalStroke withTurnColor:color];
				[explored setFrom:coord];
				[explored setTo:c];

				if ([similarStrokes containsObject:explored] == NO) {
					[list addObject:explored]; // autoreleased && rc++
				}
				[similarStrokes addObject:explored];
				// NSLog(@"similar:%lu", [similarStrokes count]);

				// [Othello logStroke:explored];
				//NSLog(@"");
			}

			// [Othello logStroke:copyOfTheOriginalStroke];
			// [list addObject:copyOfTheOriginalStroke]; // rc=2
		}
		[copyOfTheOriginalStroke release];
	}

	return list;
}

- (Stroke *)exploreFromHere:(Coord)here withStroke:(Stroke *)strokeCopy withTurnColor:(PIECE)color
{
	Coord t;
	PIECE oppositeColor = (color == WHITE) ? BLACK : WHITE;
	Stroke *copyOfTheOriginalStroke = [strokeCopy copy];

	// NSLog(@"exploreFromHere:%d,%d", here.x, here.y);

	for (int d = 0; d < 8; d++) {
		t = here;
		bool saveIt = NO;
		Stroke *currentStroke = [copyOfTheOriginalStroke copy];

		for (int i = 0; i < 8; i++) {
			t.x += allDirections[d].x;
			t.y += allDirections[d].y;

			if (t.x > 7 || t.y > 7 || t.x < 0 || t.y < 0) {
				// frame border
				saveIt = NO;
				break;
			}
			else if ([currentStroke board][INDEX(t.x, t.y)] == color) {
				// same color
				break;
			}
			else if ([currentStroke board][INDEX(t.x, t.y)] == oppositeColor) {
				// opposite color
				[currentStroke board][INDEX(t.x, t.y)] = color;
				saveIt = YES;
				continue;
			}
			else {
				// empty
				saveIt = NO;
				break;
			}
		}

		if (saveIt) {
			// [Othello logStroke:currentStroke];
			[copyOfTheOriginalStroke release];
			copyOfTheOriginalStroke = [currentStroke copy];
		}
		[currentStroke release];
	}

	return [copyOfTheOriginalStroke autorelease];
}

- (NSArray <Stroke *> *)listStrokesForColor:(PIECE)color withStroke:(Stroke *)strokeCopy
{
	NSMutableArray *list = [NSMutableArray new];
	NSMutableSet *set = [NSMutableSet new];

	@autoreleasepool {
		for (int y = 0; y < 8; y++) {
			for (int x = 0; x < 8; x++) {
				if ([strokeCopy board][INDEX(x, y)] == color) {
					Coord c = {x, y};
					NSArray *a = [self listStrokes:c withStroke:strokeCopy andStrokesSet:set];
					[list addObjectsFromArray:a];
				}
			}
		}
	}
	[set release];
	return [list autorelease];
}

- (void)exoticBlackSearch:(int)depth withOutputTree:(bool)output
{
	Stack *s = [[Stack alloc]  init];

	TreeNode *root = [[[TreeNode alloc] initWithInt:0] autorelease];

	[root setDepth:1];
	Tree *t = [[Tree alloc] initWithRoot:root];
	int count = 1;

	Stroke *rootStroke = [[self stroke] copy];

	[rootStroke setDepth:1];

	[rootStroke setParent:[t root]];
	[s push:rootStroke];

    GSDebugAllocationActive(YES);

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//@autoreleasepool {
		// purge autoreleased moves lists at every search
		while ([s count] > 0) {
			Stroke *stk = [s pop];
			//NSLog(@"popped depth:%d", [stk depth]);
			// [Othello logStroke:stk];

			// build tree
			int turn = (([stk depth] % 2 == 1) ? BLACK : WHITE);
			NSArray *moves = [self listStrokesForColor:turn withStroke:stk];
			int eval = [stk evaluate:[moves count] withTurn:turn];
			[stk setEvaluation:eval];
			TreeNode *tn = [[[TreeNode alloc] initWithInt:eval] autorelease];
			[tn setStrValue:[NSString stringWithFormat:@"%d", count++]];
			[tn setIValue:eval];
			[tn setObject:stk];
			[tn setDepth:[stk depth]];
			[t addChild:[stk parent] withChild:tn];
			[stk setParent:tn];

			if ([stk depth] == depth) {
				// stop pushing
				//NSLog(@"Depth:%d  eval:%d  stack:%d", depth, eval, [s count]);
			}
			else {
				// BLACK or WHITE ? [stk depth odd or not]
				//NSLog(@"Color %d", /*(([stk depth] % 2 == 0) ? BLACK : WHITE)*/ turn);
				// NSArray *moves = [self listStrokesForColor:(([stk depth] % 2 == 0) ? BLACK : WHITE) withStroke:stk];
				//NSLog(@"moves %lu", [moves count]);

				for (int i = 0; i < [moves count]; i++) {
					Stroke *currentStk = [moves objectAtIndex:i];
					[currentStk setDepth:[stk depth] + 1];
					[currentStk setParent:[stk parent]];
					// save previous (stk) in currentStk
					//NSLog(@"inserting previous stroke at %d", [stk depth] - 1);
					[s push:currentStk];
				}
			}
		}

        /*
        const char *alloc = GSDebugAllocationListAll();
        printf("Inside pool:%s\n", alloc);
        */

		// NSMutableString *indentString = [[NSMutableString alloc] initWithString:@""];
		//[Tree debugTree:[t root] withIndent:indentString isLast:YES];
		[[t root] setStrValue:@"ROOT"];

		[self windupScores:t];

		if (output) {
			PdfOut *pdfOut = [[PdfOut alloc] initWithDepth:depth];

			[pdfOut drawTree:[t root] fromAngle:0 toAngle:2 * M_PI showStrokes:YES];
			[pdfOut save:@"minimax.pdf"];
			[pdfOut release];
		}
	//}
	Class klassStroke = NSClassFromString(@"Stroke");
    printf("Inside pool Stroke:%d\n", GSDebugAllocationCount(klassStroke));
    [pool drain];
    // const char *alloc = GSDebugAllocationListAll();
    printf("Outside pool Stroke:%d\n", GSDebugAllocationCount(klassStroke));
    GSDebugAllocationActive(NO);

	[t release];
	[s release];
	[rootStroke release];
}

- (void)windupScores:(Tree *)t
{
	NSMutableArray *nodesList = [NSMutableArray new];

	[Tree preOrderTraversal:[t root] withSelector:@"createList:withArray:" andObject:nodesList];
	//NSLog(@"@@@@Nodes list size:%lu", [nodesList count]);

	NSSortDescriptor *depthDescriptor = [[NSSortDescriptor alloc] initWithKey:@"depth" ascending:NO];

	NSArray *descriptors = [NSArray arrayWithObjects:depthDescriptor, nil]; // autorelease
	NSArray *sortedNodesList = [nodesList sortedArrayUsingDescriptors:descriptors];

	for (int i = 0; i < [sortedNodesList count]; i++) {
		TreeNode *tn = [[sortedNodesList objectAtIndex:i] objectForKey:@"node"];
		Stroke *s = [[[sortedNodesList objectAtIndex:i] objectForKey:@"node"] object];
		int turn = (([s depth] % 2 == 1) ? BLACK : WHITE);

		if ([[tn children] count] == 0) {
			//NSLog(@"####%d", [s depth]);
			int evaluation = [[tn object] evaluation];
			[[tn object] setBestEvaluation:evaluation];
		}
		else {
			//NSLog(@"####%d", [s depth]);
			int be = (turn == BLACK ? INT_MIN : INT_MAX);

			for (int j = 0; j < [[tn children] count]; j++) {
				int ce = [[[[tn children] objectAtIndex:j] object] bestEvaluation];

				if (turn == BLACK ?  ce > be : ce < be) {
					be = ce;
				}
			}

			[[tn object] setBestEvaluation:be];
			//NSLog(@"####be=%d on %p", [[tn object] bestEvaluation], tn);
		}
	}

	[nodesList release];
	[depthDescriptor release];
}

+ (void)logStroke:(Stroke *)s
{
	NSLog(@"[%d,%d] -> [%d,%d]", [s from].x, [s from].y, [s to].x, [s to].y);

	for (int y = 0; y < 8; y++) {
		NSMutableString *line = [[NSMutableString alloc] initWithString:@""];

		for (int x = 0; x < 8; x++) {
			if ([s board][INDEX(x, y)] == WHITE) {
				[line appendString:@"W"];
			}
			else if ([s board][INDEX(x, y)] == BLACK) {
				[line appendString:@"B"];
			}
			else {
				[line appendString:@"."];
			}
		}

		NSLog(@"%@", line);
		[line release];
	}
}

@end
