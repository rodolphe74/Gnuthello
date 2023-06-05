#import <Foundation/Foundation.h>
#import "Othello.h"

int main()
{
	@autoreleasepool {
		/*
		 *  Stack *stack = [[[Stack alloc]  init] autorelease];
		 *
		 *  for (int i = 0; i < 10; i++) {
		 *   MyObject *myObject = [[MyObject new] autorelease];
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

		Othello *othello = [[Othello new] autorelease];
		[Othello logStroke:[othello stroke]];
		[othello search:3];

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
