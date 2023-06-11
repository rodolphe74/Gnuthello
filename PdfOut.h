#import <Foundation/Foundation.h>
#import "pdfgen.h"
#import "Stroke.h"

@interface PdfOut : NSObject
{
	struct pdf_doc *pdf;
}
@property (nonatomic, readwrite, assign) struct pdf_doc *pdf;
- (id)init;
- (void)dealloc;
- (void)save:(NSString *)filename;
- (void)drawStroke:(Stroke *)stroke atX:(float)x andY:(float)y;
@end
