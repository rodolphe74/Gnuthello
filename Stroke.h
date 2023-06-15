#import <Foundation/Foundation.h>
#import "Tree.h"

#define INDEX(x, y) (y * 8 + x)
#define MAX_DEPTH 256

enum PIECE_ENUM {WHITE, BLACK, EMPTY};
typedef enum PIECE_ENUM PIECE;

typedef struct _Coord {
	int x, y;
} Coord;

static int X_SQUARES[] = {1, 1, 2,
						  1, 6, 2,
						  6, 1, 2,
						  6, 6, 2,
						  0, 1, 1,
						  0, 6, 1,
						  1, 0, 1,
						  6, 0, 1,
						  7, 1, 1,
						  7, 6, 1,
						  1, 7, 1,
						  6, 7, 1};
static int NO_MOVE_LEFT_BONUS = 300;
static int MOBILITY_MUL = 2;

/*
 *  typedef struct _CoordsArray {
 *   Coord * coords;
 *   int		size;
 *  } CoordsArray;
 */

@interface Stroke : NSObject <NSCopying>
{
	PIECE *board;
	int evaluation;
	Coord from, to;
	int depth;
	TreeNode *parent;
}
@property (nonatomic, readwrite, assign) PIECE *board;
@property (nonatomic, readwrite, assign) Coord from, to;
@property (nonatomic, readwrite, assign) int evaluation;
@property (nonatomic, readwrite, assign) int depth;
@property (nonatomic, readwrite, assign) TreeNode *parent;
- (int)evaluate:(int)movesCount withTurn:(int)blackOrWhite;
@end
