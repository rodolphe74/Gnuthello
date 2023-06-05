#import "Foundation/Foundation.h"

@interface Stack : NSObject
{
	NSMutableArray *m_array;
	int count;
}
- (void)push:(id)anObject;
- (id)pop;
- (void)clear;
@property (nonatomic, readonly) int count;
@end
