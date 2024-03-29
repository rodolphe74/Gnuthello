#import <Foundation/Foundation.h>
#import "Tree.m"
#import "MyObject.m"

int main(void)
{
	// Tree test
	@autoreleasepool {
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

		[f setDepth:1];
		[b setDepth:2];
		[g setDepth:2];
		[a setDepth:3];
		[k setDepth:3];
		[d setDepth:3];
		[i setDepth:3];
		[c setDepth:4];
		[e setDepth:4];
		[h setDepth:4];

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

		NSLog(@"PreOrder");
		NSMutableDictionary *dic = [NSMutableDictionary new];
		[dic setValue:[NSNumber numberWithInt:0] forKey:@"value"];
		[Tree preOrderTraversal:[t root] withSelector:@"countLeaves:withCounter:" andObject:dic];
		NSLog(@"Found a %d feuilles", [[dic valueForKey:@"value"] intValue]);
		[dic release];

		[Tree preOrderTraversal:[t root] withSelector:@"debugNode:" andObject:nil];

		NSLog(@"PostOrder");
		[Tree postOrderTraversal:[t root] withSelector:@"debugNode:" andObject:nil];

		NSLog(@"InOrder");
		[Tree inOrderTraversalR:[t root] withSelector:@"debugNode:" andObject:nil];

		NSMutableString *indent = [[NSMutableString alloc] initWithString:@""];
		[Tree debugTree:[t root] withIndent:indent isLast:YES];
		[indent release];
		[t release];
	}
}
