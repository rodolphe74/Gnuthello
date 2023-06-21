#import "Stack.h"
@implementation Stack
@synthesize count;
- (id)init
{
	if (self = [super init]) {
		m_array = [[NSMutableArray alloc] init];
		count = 0;
	}
	return self;
}

- (void)dealloc {
	//NSLog(@"Stack dealloc");
	[m_array release];
	[super dealloc];
}

- (void)push:(id)anObject
{
	[m_array addObject:anObject];
	count = m_array.count;
}

- (id)pop
{
	id obj = nil;

	if (m_array.count > 0) {
		obj = [[[m_array lastObject]retain]autorelease];
		[m_array removeLastObject];
		count = m_array.count;
	}
	return obj;
}

- (id)peek
{
	id obj = nil;

	if (m_array.count > 0) {
		obj = [m_array lastObject];
	}
	return obj;
}

- (void)clear
{
	[m_array removeAllObjects];
	count = 0;
}

@end
