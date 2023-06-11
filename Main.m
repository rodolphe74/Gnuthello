#import <Foundation/Foundation.h>
#import "Othello.h"
#import "Tree.h"
#import "PdfOut.h"

int main()
{
	@autoreleasepool {
		/*
		 *  Stack *stack = [[[Stack alloc]  init] autorelease];
		 *
		 *  for (int i = 0; i < 10; i++) {
		 *   MyObject *myObject = [[MyOb:b ject new] autorelease];
		 *   NSLog(@"MyObject at %p before push:%lu", myObject, [myObject retainCount]);
		 *   [stack push:myObject];
		 *   NSLog(@"MyObject at %p after push:%lu", myObject, [myObject retainCount]);
		 *  }
		 *
		 *  for (int i = 0; i < 5; i++) {
		 *   MyObject *myObject = [stack pop];
		 *   NSLog(@"Popped object at %p:%lu", myObject, [myObject retainCount]);
		 *  }
		 *
		 *  NSLog(@"Stack size:%d", [stack count]);
		 */

		PdfOut *pdfOut = [PdfOut new];
		[pdfOut save:@"out.pdf"];
		[pdfOut release];

		TreeNode *a = [[[TreeNode alloc] initWithString:@"A"] autorelease];
		TreeNode *b = [[[TreeNode alloc] initWithString:@"B"] autorelease];
		TreeNode *c = [[[TreeNode alloc] initWithString:@"C"] autorelease];
		TreeNode *d = [[[TreeNode alloc] initWithString:@"D"] autorelease];
		TreeNode *e = [[[TreeNode alloc] initWithString:@"E"] autorelease];
		TreeNode *f = [[[TreeNode alloc] initWithString:@"F"] autorelease];
		TreeNode *g = [[[TreeNode alloc] initWithString:@"G"] autorelease];
		TreeNode *h = [[[TreeNode alloc] initWithString:@"H"] autorelease];
		TreeNode *i = [[[TreeNode alloc] initWithString:@"I"] autorelease];
		TreeNode *k = [[[TreeNode alloc] initWithString:@"K"] autorelease];

		NSLog(@"%@", [f strValue]);
		Tree *t = [[Tree alloc] initWithRoot:f];
		[t addChild:f withChild:b];
		[t addChild:f withChild:g];
		[t addChild:b withChild:a];
		[t addChild:b withChild:k];
		[t addChild:b withChild:d];
		[t addChild:d withChild:c];
		[t addChild:d withChild:e];
		[t addChild:g withChild:i];
		[t addChild:i withChild:h];

		/*
		 *    TreeNode *p = [t findParent:e fromNode:f];
		 *    NSLog(@"P:%@", [p strValue]);
		 *
		 *    NSLog(@"PreOrder");
		 *    [t preOrderTraversal:[t root] withSelector:@"debugNode:"];
		 *
		 *    NSLog(@"PostOrder");
		 *    [t postOrderTraversal:[t root] withSelector:@"debugNode:"];
		 *
		 *    NSLog(@"InOrder");
		 *    [t inOrderTraversalR:[t root] withSelector:@"debugNode:"];
		 */
		NSMutableString *indent = [[NSMutableString alloc] initWithString:@""];
		[Tree debugTree:[t root] withIndent:indent isLast:YES];
		[indent release];
		[t release];

		Othello *othello = [[Othello new] autorelease];
		[Othello logStroke:[othello stroke]];
		[othello exoticBlackSearch:5];

		/*
		 *  NSArray *moves = [othello listStrokes:BLACK];
		 *  NSLog(@"Found %lu", [moves count]);
		 *
		 *  for (int i = 0; i < [moves count]; i++) {
		 *   [Othello logStroke:[moves objectAtIndex:i]];
		 *   NSLog(@"--");
		 *  }
		 */

		/*
		 *  Stroke *sc = [[[othello stroke] copy] autorelease];
		 *  [Othello logStroke:sc];
		 *  Coord c = {4, 4};
		 *  NSArray *a = [othello listStrokes:c withStroke:sc];
		 *  NSLog(@"Found %lu", [a count]);
		 *
		 *  for (int i = 0; i < [a count]; i++) {
		 *   [Othello logStroke:[a objectAtIndex:i]];
		 *   NSLog(@"--");
		 *  }
		 */
	}
	return 0;
}
