#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <GNUstepGUI/GSHbox.h>
#import <GNUstepGUI/GSVbox.h>

#import "GnuController.h"

int
main(int argc, const char **argv)
{
	NSApplication *app;
	GnuController *controller;

	app = [NSApplication sharedApplication];
	controller = [GnuController new]; // released in self:applicationWillTerminate
	[app setDelegate:controller];
	[app run];
	return 0;
}
