#import "GnuController.h"

@implementation GnuController

- (id)init
{
	return self;
}

- (void)dealloc
{
	NSLog(@"GnuController dealloc");
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
{
	[self startNewGnuWindow:nil];
}

- (void)startNewGnuWindow:(id)sender
{
	mainWindow = [[GnuWindow alloc] init];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
	return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	NSLog(@"NSLog applicationWillTerminate");
	[mainWindow release];
	[self release];
}

@end
