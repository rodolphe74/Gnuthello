#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface Tree : NSObject
{
	TreeNode *root;
}
@property (nonatomic, readwrite, assign) TreeNode *root;
- (id)initWithRoot:(TreeNode *)root;
- (void)dealloc;
- (void)addChild:(TreeNode *)parent withChild:(TreeNode *)child;
- (TreeNode *)findParent:(TreeNode *)node fromNode:(TreeNode *)startNode;
- (void)preOrderTraversal:(TreeNode *)startNode withSelector:(NSString *)selector andObject:(id)object;
- (void)postOrderTraversal:(TreeNode *)startNode withSelector:(NSString *)selector andObject:(id)object;
- (void)inOrderTraversalR:(TreeNode *)startNode withSelector:(NSString *)selector andObject:(id)object;
+ (void)debugNode:(TreeNode *)node;
+ (void)countLeaves:(TreeNode *)node withCounter:(id)leavesCounter;
+ (void)debugTree:(TreeNode *)root withIndent:(NSMutableString *)indentString isLast:(bool)isLast;
@end
