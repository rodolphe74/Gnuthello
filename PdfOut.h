#import <Foundation/Foundation.h>
#import <math.h>
#import "pdfgen.h"
#import "Stroke.h"

static const double CIRCLE_RADIUS = 20.0;
static const double DELTA = M_PI;

@interface PdfOut : NSObject
{
	struct pdf_doc *pdf;
}
@property (nonatomic, readwrite, assign) struct pdf_doc *pdf;
- (id)init;
- (void)dealloc;
- (void)save:(NSString *)filename;
- (void)drawStroke:(Stroke *)stroke atX:(float)x andY:(float)y;
- (void)drawTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta;
@end
