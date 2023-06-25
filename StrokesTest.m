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

int main(void)
{
	@autoreleasepool {
		Othello *o = [[[Othello alloc] initWithBoard:board] autorelease];

		[Othello logStroke:[o stroke]];
        NSLog(@"");

		NSArray *moves = [o listStrokesForColor:BLACK withStroke:[o stroke]];

		NSLog(@"Found %lu moves", [moves count]);

		for (int i = 0; i < [moves count]; i++) {
			[Othello logStroke:[moves objectAtIndex:i]];
		}
	}
}
