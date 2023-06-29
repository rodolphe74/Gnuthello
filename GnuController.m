
#import "GnuController.h"

@implementation GnuController

-(id) init
{
  return self;
}

-(void) dealloc
{
  [super dealloc];
}

- (void)applicationDidFinishLaunching: (NSNotification *)aNotification;
{
  [self startNewFractalWindow: nil];
}

- (void)startNewFractalWindow: (id)sender
{
  int tag;
  tag = (sender==nil ? DEFAULT_TYPE:[sender tag]);
  
  [[GnuWindow alloc] initWithType:tag];
}

@end

