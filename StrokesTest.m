#import <Foundation/Foundation.h>
#import "Othello.h"

PIECE board[64] = {
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 1, 2, 2, 2,
	2, 2, 2, 1, 0, 1, 2, 2,
	2, 2, 1, 1, 0, 1, 1, 2,
	2, 2, 2, 0, 0, 0, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
};

PIECE anotherBoard[64] = {
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 1, 2, 2, 2,
	2, 2, 2, 1, 0, 1, 2, 2,
	2, 2, 1, 1, 0, 1, 1, 2,
	2, 2, 2, 0, 0, 0, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 2, 2, 2, 2, 2, 2,
};

int main(void)
{
	@autoreleasepool {
		// Testing equality
		Othello *o = [[[Othello alloc] initWithBoard:board] autorelease];
		Othello *o2 = [[[Othello alloc] initWithBoard:anotherBoard] autorelease];

		if ([[o stroke] isEqual:[o2 stroke]]) {
			NSLog(@"Equal");
		}

		NSMutableSet *similarStrokes = [NSMutableSet new];
		[similarStrokes addObject:[o stroke]];
		[similarStrokes addObject:[o2 stroke]];
		NSLog(@"Set size:%lu", [similarStrokes count]);
		[similarStrokes release];

		// Testing strokes generation
		[Othello logStroke:[o stroke]];
		NSLog(@"");

		NSArray *moves = [o listStrokesForColor:BLACK withStroke:[o stroke]];

		NSLog(@"Found %lu moves", [moves count]);

		for (int i = 0; i < [moves count]; i++) {
			[Othello logStroke:[moves objectAtIndex:i]];
		}
	}
}
