#import <Foundation/Foundation.h>
#import <math.h>
#import "Othello.h"
#import "Tree.h"
#import "PdfOut.h"

int main()
{
	@autoreleasepool {
		// Minimax && Pdf output tree
		Othello *othello = [[Othello new] autorelease];
		[Othello logStroke:[othello stroke]];
		[othello exoticBlackSearch:7];
	}
	return 0;
}
