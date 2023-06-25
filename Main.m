#import <Foundation/Foundation.h>
#import <math.h>
#import "Othello.h"
#import "Tree.h"
#import "PdfOut.h"

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

int main()
{
	@autoreleasepool {
		// Minimax && Pdf output tree
		// Othello *othello = [[Othello new] autorelease];
		Othello *othello = [[[Othello alloc] initWithBoard:board] autorelease];
		[Othello logStroke:[othello stroke]];
		[othello exoticBlackSearch:4];
	}
	return 0;
}
