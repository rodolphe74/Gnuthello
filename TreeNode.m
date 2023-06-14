#import <Foundation/Foundation.h>
#import "TreeNode.h"

@implementation TreeNode
@synthesize children;
@synthesize iValue;
@synthesize strValue;
@synthesize object;
@synthesize depth;
- (id)init
{
	if (self = [super init]) { // equivalent to "self does not equal nil"
		NSLog(@"init TreeNode at %p", self);

		children = [NSMutableArray new];
		iValue = 0;
		[strValue initWithString:@""];
		object = nil;
		depth = 1;
	}
	return self;
}

- (id)initWithInt:(int)i
{
	self = [self init];

	if (self) {
		[self setIValue:i];
	}
	return self;
}

- (id)initWithString:(NSString *)s
{
	self = [self init];

	if (self) {
		[self setStrValue:s];
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"deallocating TreeNode at %p", self);
	[strValue release];
	[children removeAllObjects];
	[children release];
	[super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
	NSLog(@"allocWithZone");
	TreeNode *copy = [[TreeNode allocWithZone:zone] init];

	[copy setIValue:iValue];
	[copy setStrValue:strValue];
	return copy;
}

@end
