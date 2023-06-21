#import <Foundation/Foundation.h>
#import "Stack.m"
#import "MyObject.m"

int main(void)
{
	// Stack test
	@autoreleasepool {
		Stack *stack = [[[Stack alloc]  init] autorelease];

		for (int i = 0; i < 10; i++) {
			MyObject *myObject = [[MyObject new] autorelease];
			NSLog(@"MyObject at %p before push:%lu", myObject, [myObject retainCount]);
			[stack push:myObject];
			NSLog(@"MyObject at %p after push:%lu", myObject, [myObject retainCount]);
		}

		for (int i = 0; i < 5; i++) {
			MyObject *myObject = [stack pop];
			NSLog(@"Popped object at %p:%lu", myObject, [myObject retainCount]);
		}

		NSLog(@"Stack size:%d", [stack count]);
	}
}
