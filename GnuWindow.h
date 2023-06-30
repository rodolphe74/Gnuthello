#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "GnuView.h"

@interface GnuWindow : NSObject
{
	id delegate;
	NSWindow *window;
	GnuView *view;
}

- (id)delegate;
- (void)setDelegate:(id)aDelegate;
- (id)window;

@end
