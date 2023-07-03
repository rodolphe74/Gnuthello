#import "GnuWindow.h"

@implementation GnuWindow

- (id)init
{
	if ((self = [super init]) != nil) {
		NSRect frame;
		int m = (NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask |
			NSMiniaturizableWindowMask);

		view = [[GnuView alloc] init];
		frame = [NSWindow frameRectForContentRect:[view frame]
			styleMask:m];

		window = [[NSWindow alloc] initWithContentRect:frame
			styleMask:m
			backing:NSBackingStoreRetained
			defer:YES];
		[window setMinSize:frame.size];
		[window setTitle:@"Gnuthello"];
		[window setReleasedWhenClosed:NO];
		[window setDelegate:self];

		[window setFrame:frame display:YES];
		[window setMaxSize:frame.size];
		[window setContentView:view];
		[window setReleasedWhenClosed:YES];

		// [window setContentSize:NSMakeSize(640, 640)];
		
		[window center];
		[window orderFrontRegardless];
		[window makeKeyWindow];
		[window display];
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"GnuWindow dealloc");
	[view dealloc];
	[super dealloc];
}

- (id)delegate
{
	return delegate;
}

- (void)setDelegate:(id)aDelegate
{
	delegate = aDelegate;
}

- (id)window
{
	return window;
}

@end
