#import <Foundation/Foundation.h>
#import "Tree.h"
#import "Stack.h"

@implementation Tree
@synthesize root;
- (id)initWithRoot:(TreeNode *)r
{
	if (self = [super init]) { // equivalent to "self does not equal nil"
		[self setRoot:r];
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"deallocating Tree at %p", self);
	[super dealloc];
}

- (void)addChild:(TreeNode *)parent withChild:(TreeNode *)child
{
	[[parent children] addObject:child];
}

- (TreeNode *)findParent:(TreeNode *)node fromNode:(TreeNode *)startNode
{
	TreeNode *p = nil;
	Stack *s = [Stack new];

	[s push:startNode];

	while ([s count] > 0) {
		TreeNode *t = [s pop];
		// NSLog(@"Traversing TreeNode %@", [t strValue]);

		for (int i = [[t children] count] - 1; i >= 0; i--) {
			TreeNode *c = [[t children] objectAtIndex:i];

			if (c == node) {
				p = t;
				break;
			}
			[s push:c];
		}
	}

	[s release];
	return p;
}

- (void)preOrderTraversal:(TreeNode *)startNode withSelector:(NSString *)selector
{
	Class klass = NSClassFromString(@"Tree");
	SEL sel = NSSelectorFromString(selector);

	Stack *s = [Stack new];

	[s push:startNode];

	while ([s count] > 0) {
		TreeNode *t = [s pop];
		// NSLog(@"Traversing TreeNode %@", [t strValue]);
		[klass performSelector:sel withObject:t];

		for (int i = [[t children] count] - 1; i >= 0; i--) {
			TreeNode *c = [[t children] objectAtIndex:i];
			[s push:c];
		}
	}

	[s release];
}

- (void)postOrderTraversal:(TreeNode *)startNode withSelector:(NSString *)selector
{
	Class klass = NSClassFromString(@"Tree");
	SEL sel = NSSelectorFromString(selector);

	Stack *s = [Stack new];

	TreeNode *r = startNode;
	int currentRootIndex = 0;

	while (r != nil || [s count] > 0) {
		if (r != nil) {
			NSMutableDictionary *pair = [NSMutableDictionary new];
			[pair setValue:r forKey:@"node"];
			[pair setValue:[NSNumber numberWithInt:currentRootIndex] forKey:@"index"];
			[s push:pair];
			[pair release];
			currentRootIndex = 0;

			if ([[r children] count] >= 1) {
				r = [[r children] objectAtIndex:0];
			}
			else {
				r = nil;
			}
			continue;
		}

		NSDictionary *temp = [s pop];
		// NSLog(@"*>%@", [[temp objectForKey:@"node"] strValue]);
		TreeNode *t = [temp objectForKey:@"node"];
		[klass performSelector:sel withObject:t];

		while ([s count] > 0 && [[temp objectForKey:@"index"] intValue] == [[[[s peek] objectForKey:@"node"] children] count] - 1) {
			temp = [s pop];
			TreeNode *u = [temp objectForKey:@"node"];
			[klass performSelector:sel withObject:u];
		}

		if ([s count] > 0) {
			// NSLog(@"ICI:%d", [s count]);
			int index = [[temp objectForKey:@"index"] intValue] + 1;
			r = [[[[s peek] objectForKey:@"node"] children] objectAtIndex:index];
			// NSLog(@"ICI2:%p %@", r, [r strValue]);
			currentRootIndex = index;
		}
	}

	[s release];
}

- (void)inOrderTraversalR:(TreeNode *)startNode withSelector:(NSString *)selector
{
	Class klass = NSClassFromString(@"Tree");
	SEL sel = NSSelectorFromString(selector);

	if (startNode == nil) {
		return;
	}

	int total = [[startNode children] count];

	if (total == 0) {
		[klass performSelector:sel withObject:startNode];
		return;
	}

	for (int i = 0; i < total - 1; i++) {
		[self inOrderTraversalR:[[startNode children] objectAtIndex:i] withSelector:selector];
	}

	[klass performSelector:sel withObject:startNode];

	// Last child
	[self inOrderTraversalR:[[startNode children] objectAtIndex:total - 1] withSelector:selector];
}

+ (void)debugNode:(TreeNode *)node
{
	NSLog(@"Node at %p = [%@,%d]", node, [node strValue], [node iValue]);
}

+ (void)debugTree:(TreeNode *)root withIndent:(NSMutableString *)indentString isLast:(bool)isLast
{
	/*
	 *  Console.Write(indent + "+- " + tree.Name);
	 *  indent += last ? "   " : "|  ";
	 *
	 *  for (int i = 0; i < tree.Children.Count; i++)
	 *  {
	 *   PrintTree(tree.Children[i], indent, i == tree.Children.Count - 1);
	 *  }
	 */

	NSLog(@"%@+- %d,%@", indentString, [root iValue], [root strValue]);
	NSMutableString *reIndentString = [indentString mutableCopy];

	if (isLast == YES) {
		[reIndentString appendString:@"   "];
	}
	else {
		[reIndentString appendString:@"|  "];
	}

	for (int i = 0; i < [[root children] count]; i++) {
		[Tree debugTree:[[root children] objectAtIndex:i] withIndent:reIndentString isLast:i == [[root children] count] - 1];
	}

	[reIndentString release];
}

@end
