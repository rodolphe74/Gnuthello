#import <Foundation/Foundation.h>
#import <math.h>
#import "pdfgen.h"
#import "Stroke.h"

static const double RADIUS = 0.0;
static const double RADIUS_INCREMENT = 320.0;
static const double NODE_RADIUS = 4.0;
static const double FONT_SIZE = 18;
//static const double PDF_HEIGHT = 5600;
//static const double PDF_WIDTH = 4000;
static const double PDF_HEIGHT_DEPTH_UNITY = (5600 / 7);
static const double PDF_WIDTH_DEPTH_UNITY = (4000 / 7);
static const int DEPTH = 7;

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
- (void)drawTree:(TreeNode *)root fromAngle:(double)alfa toAngle:(double)beta showStrokes:(bool)showStrokes;
@end
