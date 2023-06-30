#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "GnuWindow.h"
#import "GnuView.h"

@interface GnuController : NSObject <NSApplicationDelegate, NSWindowDelegate>
{
	GnuWindow *mainWindow;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
- (void)startNewGnuWindow:(id)sender;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app;
- (void)applicationWillTerminate:(NSNotification *)aNotification;

@end
