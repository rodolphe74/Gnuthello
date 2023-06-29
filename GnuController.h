#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "GnuWindow.h"
#import "GnuView.h"

@interface GnuController : NSObject

-(void)applicationDidFinishLaunching: (NSNotification *)aNotification;

-(void)startNewFractalWindow: (id)sender;

@end

