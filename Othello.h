#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Stroke.h"

@interface Othello : NSObject
{
	Stroke *stroke;
	Stack *stack;
}
@property (nonatomic, readonly) Stroke *stroke;
- (id)initWithBoard:(PIECE *)board;
- (NSArray <Stroke *> *)listStrokes:(Coord)coord withStroke:(Stroke *)strokeCopy;
- (NSArray <Stroke *> *)listStrokesForColor:(PIECE)color withStroke:(Stroke *)strokeCopy;
- (void)exoticBlackSearch:(int)depth;
- (void)windupScores:(Tree *)t;
+ (void)logStroke:(Stroke *)s;
@end
