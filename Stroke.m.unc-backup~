#import "Stroke.h"
#import <string.h>

@implementation Stroke
@synthesize board;
@synthesize evaluation;
@synthesize from, to;
@synthesize depth;
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
	Stroke *strokeCopy = [[Stroke allocWithZone:zone] init];

	memcpy([strokeCopy board], [self board], sizeof(PIECE) * 8 * 8);
	strokeCopy->evaluation = evaluation;
	strokeCopy->from = from;
	strokeCopy->to = to;

	// NSLog(@"Copying Stroke at %p to %p", self, strokeCopy);
	return strokeCopy;
}

- (int)evaluate
{
	int sum = 0;

	for (int y = 0; y < 8; y++) {
		for (int x = 0; x < 8; x++) {
			if ([self board][INDEX(x, y)] == BLACK) {
				sum--;
			}
			else if ([self board][INDEX(x, y)] == WHITE) {
				sum++;
			}
		}
	}

	return sum;
}

@end
