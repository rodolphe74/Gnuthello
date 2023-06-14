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

- (void)dealloc
{
	NSLog(@"Othello dealloc");
	[stack release];
	[stroke release];
	[super dealloc];
}

/* Computer is black */

/*
 *  - (void)freeCoordsArray:(CoordsArray)coordsArray
 *  {
 *   free(coordsArray.coords);
 *  }
 */

- (NSArray <Stroke *> *)listStrokes:(Coord)coord withStroke:(Stroke *)strokeCopy;
{
	static Coord allDirections[] = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}};
	Coord t;
	NSMutableArray *list = [[NSMutableArray new] autorelease];
	PIECE color = [strokeCopy board][INDEX(coord.x, coord.y)];
	PIECE oppositeColor = (color == WHITE) ? BLACK : WHITE;

	for (int d = 0; d < 4; d++) {
		t = coord;
		bool saveIt = NO;
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
				// empty
				break;
			}
		}

		if (saveIt) {
			// NSLog(@"save dir %d,%d", allDirections[d].x, allDirections[d].y);
			[copyOfTheOriginalStroke board][INDEX(t.x, t.y)] = color;
			// [Othello logStroke:copyOfTheOriginalStroke];
			[list addObject:copyOfTheOriginalStroke]; // rc=2
		}
		[copyOfTheOriginalStroke release];
	}

	return list;
}

- (NSArray <Stroke *> *)listStrokesForColor:(PIECE)color withStroke:(Stroke *)strokeCopy
{
	NSMutableArray *list = [NSMutableArray new];

	@autoreleasepool {
		for (int y = 0; y < 8; y++) {
			for (int x = 0; x < 8; x++) {
				if ([strokeCopy board][INDEX(x, y)] == color) {
					Coord c = {x, y};
					NSArray *a = [self listStrokes:c withStroke:strokeCopy];
					[list addObjectsFromArray:a];
				}
			}
		}
	}
	return [list autorelease];
}

/*
 *  - (NSArray <Stroke *> *)listStrokes:(PIECE)color
 *  {
 *   Stroke *strokeCopy = [stroke copy];
 *   NSMutableArray *list = [NSMutableArray new];
 *
 *   @autoreleasepool {
 *       for (int y = 0; y < 8; y++) {
 *           for (int x = 0; x < 8; x++) {
 *               if ([strokeCopy board][INDEX(x, y)] == color) {
 *                   Coord c = {x, y};
 *                   NSArray *a = [self listStrokes:c withStroke:strokeCopy];
 *                   [list addObjectsFromArray:a];
 *               }
 *           }
 *       }
 *   }
 *   [strokeCopy release];
 *   return [list autorelease];
 *  }
 */
/*
 *  - (int)evaluate
 *  {
 *   int sum = 0;
 *
 *   for (int y = 0; y < 8; y++) {
 *       for (int x = 0; x < 8; x++) {
 *           if ([stroke board][INDEX(x, y)] == BLACK) {
 *               sum++;
 *               NSLog(@"B++");
 *           }
 *           else {
 *               sum--;
 *               NSLog(@"W--");
 *           }
 *       }
 *   }
 *
 *   return sum;
 *  }
 */
- (void)exoticBlackSearch:(int)depth
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

	@autoreleasepool {
		// purge autoreleased moves lists at every search
		while ([s count] > 0) {
			Stroke *stk = [s pop];
			NSLog(@"popped depth:%d", [stk depth]);
			[Othello logStroke:stk];

			// build tree
			int eval = [stk evaluate];
			TreeNode *tn = [[[TreeNode alloc] initWithInt:eval] autorelease];
			[tn setStrValue:[NSString stringWithFormat:@"%d", count++]];
			[tn setObject:stk];
			[tn setDepth:[stk depth]];
			[t addChild:[stk parent] withChild:tn];
			[stk setParent:tn];

			if ([stk depth] == depth) {
				// stop pushing
				NSLog(@"Depth:%d  eval:%d  stack:%d", depth, eval, [s count]);
			}
			else {
				// BLACK or WHITE ? [stk depth odd or not]
				NSLog(@"Color %d", (([stk depth] % 2 == 0) ? BLACK : WHITE));
				NSArray *moves = [self listStrokesForColor:(([stk depth] % 2 == 0) ? BLACK : WHITE) withStroke:stk];
				NSLog(@"moves %lu", [moves count]);

				for (int i = 0; i < [moves count]; i++) {
					Stroke *currentStk = [moves objectAtIndex:i];
					[currentStk setDepth:[stk depth] + 1];
					[currentStk setParent:[stk parent]];
					// save previous (stk) in currentStk
					NSLog(@"inserting previous stroke at %d", [stk depth] - 1);
					[s push:currentStk];
				}
			}
		}

		NSLog(@"Best path:");
	}

	NSMutableString *indentString = [[NSMutableString alloc] initWithString:@""];

	[Tree debugTree:[t root] withIndent:indentString isLast:YES];
    [[t root] setStrValue:@"ROOT"];

    PdfOut *pdfOut = [PdfOut new];
    [pdfOut drawTree:[t root] fromAngle:0 toAngle:2*M_PI];
    [pdfOut save:@"minimax.pdf"];
    [pdfOut release];

	[t release];
	[s release];
	[rootStroke release];
}

+ (void)logStroke:(Stroke *)s
{
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
