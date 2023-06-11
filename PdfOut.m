#import "PdfOut.h"

@implementation PdfOut
@synthesize pdf;
- (id)init
{
	if (self = [super init]) {
		struct pdf_info info = {
			.creator	= "Gnutello",
			.producer	= "Gnustep",
			.title		= "Minimax tree",
			.author		= "Gnutello",
			.subject	= "trying to display the best path from a minimax tree",
			.date		= "Today"
		};

		pdf = pdf_create(PDF_A4_WIDTH, PDF_A4_HEIGHT, &info);
		pdf_set_font(pdf, "Times-Roman");
		pdf_append_page(pdf);
		pdf_add_text(pdf, NULL, "This is text", 12, 0, PDF_A4_HEIGHT - 12, PDF_BLACK);
	}
	return self;
}

- (void)dealloc
{
	NSLog(@"deallocating PdfOut at %p", self);
	pdf_destroy(pdf);
	[super dealloc];
}

- (void)save:(NSString *)filename
{
	pdf_save(pdf, [filename cString]);
}

- (void)drawStroke:(Stroke *)stroke atX:(float)x andY:(float)y;
{
}

@end
