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

- (void)drawStroke:(Stroke *)stroke atX:(float)atx andY:(float)aty;
{
	float x1, y1, x2, y2;
	float multiplier = .08f;

	for (int i = 0; i <= 8; i++) {
		x1 = atx;
		x2 = atx + 8 * 6 * multiplier;
		y1 = aty + i * 6 * multiplier;
		y2 = aty + i * 6 * multiplier;
		pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f * multiplier, PDF_BLACK);

		x1 = atx + i * 6 * multiplier;
		x2 = atx + i * 6 * multiplier;
		y1 = aty;
		y2 = aty + 8 * 6 * multiplier;
		pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f * multiplier, PDF_BLACK);
	}

	for (int y = 0; y < 8; y++) {
		for (int x = 0; x < 8; x++) {
			if ([stroke board][INDEX(x, y)] == WHITE) {
				pdf_add_circle(pdf, NULL, (x + 1) * 6 * multiplier + atx - 3 * multiplier, ((7 - y) + 1) * 6 * multiplier + aty - 3 * multiplier, 2.0f * multiplier, 1.0f * multiplier, PDF_BLACK, PDF_WHITE);
			}
			else if ([stroke board][INDEX(x, y)] == BLACK) {
				pdf_add_circle(pdf, NULL, (x + 1) * 6 * multiplier + atx - 3 * multiplier, ((7 - y) + 1) * 6 * multiplier + aty - 3 * multiplier, 2.0f * multiplier, 1.0f * multiplier, PDF_BLACK, PDF_BLACK);
			}
			else {
				// Empty
			}
		}
	}
}

/*
 *  - (void)drawStroke:(Stroke *)stroke atX:(float)atx andY:(float)aty;
 *  {
 *   int x1, y1, x2, y2;
 *
 *   for (int i = 0; i <= 8; i++) {
 *       x1 = atx;
 *       x2 = atx + 8 * 6;
 *       y1 = aty + i * 6;
 *       y2 = aty + i * 6;
 *       pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f, PDF_BLACK);
 *
 *       x1 = atx + i * 6;
 *       x2 = atx + i * 6;
 *       y1 = aty;
 *       y2 = aty + 8 * 6;
 *       pdf_add_line(pdf, NULL, x1, y1, x2, y2, 1.0f, PDF_BLACK);
 *   }
 *
 *   for (int y = 0; y < 8; y++) {
 *       for (int x = 0; x < 8; x++) {
 *           if ([stroke board][INDEX(x, y)] == WHITE) {
 *               pdf_add_circle(pdf, NULL, (x+1) * 6 + atx - 3, ((7-y)+1) * 6 + aty - 3, 2.0f, 1.0f, PDF_BLACK, PDF_WHITE);
 *           }
 *           else if ([stroke board][INDEX(x, y)] == BLACK) {
 *               pdf_add_circle(pdf, NULL, (x+1) * 6 + atx - 3, ((7-y)+1) * 6 + aty - 3, 2.0f, 1.0f, PDF_BLACK, PDF_BLACK);
 *           }
 *           else {
 *               // Empty
 *           }
 *       }
 *   }
 *  }
 */

@end
