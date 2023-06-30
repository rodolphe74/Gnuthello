#import "GnuView.h"

@implementation GnuView

- (void)update
{}

- (void)drawRect:(NSRect)aRect
{
	NSBezierPath *line = [NSBezierPath bezierPath];

	[line moveToPoint:NSMakePoint(NSMinX([self bounds]), NSMinY([self bounds]))];
	[line lineToPoint:NSMakePoint(NSMaxX([self bounds]), NSMaxY([self bounds]))];
	[line setLineWidth:5.0]; /// Make it easy to see
	[line stroke];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint startp, curp;
	NSEvent *curEvent = theEvent;

	startp = [curEvent locationInWindow];
	startp = [self convertPoint:startp fromView:nil];
	NSLog(@"startp:%f,%f", startp.x, startp.y);

	do {
		curp = [curEvent locationInWindow];
		curp = [self convertPoint:curp fromView:nil];
		curEvent =
			[[self window]
			nextEventMatchingMask:
			NSLeftMouseUpMask | NSLeftMouseDraggedMask];
	} while([curEvent type] != NSLeftMouseUp);
	NSLog(@"curp:%f,%f", curp.x, curp.y);
}

- (void)dealloc
{
	NSLog(@"GnuView dealloc");
	[super dealloc];
}

@end
