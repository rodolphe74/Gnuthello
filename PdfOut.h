#import <Foundation/Foundation.h>
#import <math.h>
#import "pdfgen.h"
#import "Stroke.h"

static const double RADIUS = 10.0;
static const double RADIUS_INCREMENT = 40.0;
static const double NODE_RADIUS = 1.0;
static const double FONT_SIZE = 4;

@interface PdfOut : NSObject
{
	struct pdf_doc *pdf;
}
@property (nonatomic, readwrite, assign) struct pdf_doc *pdf;
- (id)init;
- (void)dealloc;
- (void)save:(NSString *)filename;
- (void)drawStroke:(Stroke *)stroke atX:(float)x andY:(float)y;
- (void)computeTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta withCircleRadius:(double)circleRadius withRadialIncrement:(double)radialIncrement withDic:(NSMutableDictionary *)positions;
- (void)drawTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta;
@end
