#import <Foundation/Foundation.h>

@interface TreeNode : NSObject <NSCopying>
{
	NSMutableArray <TreeNode *> *children;
	int iValue;
	NSString *strValue;
	id object;
	int depth;
}
@property (nonatomic, readwrite, assign) NSMutableArray <TreeNode *> *children;
@property (nonatomic, readwrite, assign) int iValue;
@property (nonatomic, readwrite, copy) NSString *strValue;
@property (nonatomic, readwrite, assign) id object;
@property (nonatomic, readwrite, assign) int depth;
- (id)initWithInt:(int)i;
- (id)initWithString:(NSString *)s;
- (void)dealloc;
@end
