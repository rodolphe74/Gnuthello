#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Stroke.h"

//#define INDEX(x, y) (y * 8 + x)
//#define MAX_COORDS 64

@interface Othello : NSObject
{
	Stroke *stroke;
	Stack *stack;
}
@property (nonatomic, readonly) Stroke *stroke;
// - (void)freeCoordsArray:(CoordsArray)coordsArray;
- (NSArray <Stroke *> *)listStrokes:(Coord)coord withStroke:(Stroke *)strokeCopy;
- (NSArray <Stroke *> *)listStrokesForColor:(PIECE)color withStroke:(Stroke *)strokeCopy;
// -(NSArray <Stroke *> *)listStrokes: (PIECE)color;
- (int)evaluate;
- (void)search:(int)depth;
+ (void)logStroke:(Stroke *)s;
@end
