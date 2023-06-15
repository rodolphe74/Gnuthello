#import "Stroke.h"
#import <string.h>
#import "Tree.h"

@implementation Stroke
@synthesize board;
@synthesize evaluation;
@synthesize from, to;
@synthesize depth;
@synthesize parent;
- (id)init
{
	if (self = [super init]) {
		NSLog(@"Stroke init at %p", self);
		board = (PIECE *)malloc(sizeof(PIECE) * 8 * 8);
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"Stroke dealloc at %p", self);
	free(board);
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
	NSLog(@"allocWithZone");
	Stroke *strokeCopy = [[Stroke allocWithZone:zone] init];

	memcpy([strokeCopy board], [self board], sizeof(PIECE) * 8 * 8);
	strokeCopy->evaluation = evaluation;
	strokeCopy->from = from;
	strokeCopy->to = to;
	return strokeCopy;
}

- (int)evaluate:(int)movesCount withTurn:(int)blackOrWhite
{
	int sum = 0;

	/*
	 * Black player evaluation
	 * X squares - B2, B7, G2, and G7 - Worse (They give access to adjacent corner)
	 * C squares - A2, A7, B1, G1, H2, H7, B8, and G8. - Worse (They offer the opponent access to corners)
	 * Mobility - Better
	 * No Move left - Big Bonus
	 */

	// Mobility
	if (blackOrWhite == BLACK) {
		sum += movesCount * MOBILITY_MUL;
	}

	// Looser : White Bonus
	if (movesCount == 0 && blackOrWhite == BLACK) {
		sum -= NO_MOVE_LEFT_BONUS;
	}

	// Mobility
	if (blackOrWhite == WHITE) {
		sum -= movesCount * MOBILITY_MUL;
	}

	// Looser : Black bonus
	if (movesCount == 0 && blackOrWhite == WHITE) {
		sum += NO_MOVE_LEFT_BONUS;
	}

	for (int y = 0; y < 8; y++) {
		for (int x = 0; x < 8; x++) {
			if ([self board][INDEX(x, y)] == BLACK) {
				sum++;

				// check x & c
				for (int i = 0; i < sizeof(X_SQUARES) / sizeof(int); i += 3) {
					NSLog(@"@@@%d)%d", i, X_SQUARES[i]);

					if (x == X_SQUARES[i] && y == X_SQUARES[i + 1]) {
						sum -= X_SQUARES[i + 2];
					}
				}
			}
			else if ([self board][INDEX(x, y)] == WHITE) {
				sum--;

				// check x & c
				for (int i = 0; i < sizeof(X_SQUARES) / sizeof(int); i += 3) {
					NSLog(@"@@@%d)%d", i, X_SQUARES[i]);

					if (x == X_SQUARES[i] && y == X_SQUARES[i + 1]) {
						sum += X_SQUARES[i + 2];
					}
				}
			}
		}
	}

	return sum;
}

@end
