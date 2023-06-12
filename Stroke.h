#import <Foundation/Foundation.h>
#import "Tree.h"

#define INDEX(x, y) (y * 8 + x)
#define MAX_DEPTH 256

enum PIECE_ENUM {WHITE, BLACK, EMPTY};
typedef enum PIECE_ENUM PIECE;

typedef struct _Coord {
	int x, y;
} Coord;

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
	// Stroke **path;
	TreeNode *parent;
}
@property (nonatomic, readwrite, assign) PIECE *board;
@property (nonatomic, readwrite, assign) Coord from, to;
@property (nonatomic, readwrite, assign) int evaluation;
@property (nonatomic, readwrite, assign) int depth;
// @property (nonatomic, readwrite, assign) Stroke **path;
@property (nonatomic, readwrite, assign) TreeNode *parent;
- (int)evaluate;
@end
