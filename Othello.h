#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Stroke.h"

static Coord allDirections[] = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

@interface Othello : NSObject
{
	Stroke *stroke;
	Stack *stack;
}
@property (nonatomic, readonly) Stroke *stroke;
- (id)initWithBoard:(PIECE *)board;
- (NSArray <Stroke *> *)listStrokes:(Coord)coord withStroke:(Stroke *)strokeCopy andStrokesSet:(NSMutableSet *)similarStrokes;
- (NSArray <Stroke *> *)listStrokesForColor:(PIECE)color withStroke:(Stroke *)strokeCopy;
- (Stroke *)exploreFromHere:(Coord)here withStroke:(Stroke *)strokeCopy withTurnColor:(PIECE)color;
- (void)exoticBlackSearch:(int)depth withOutputTree:(bool)output;
- (void)windupScores:(Tree *)t;
+ (void)logStroke:(Stroke *)s;
@end
