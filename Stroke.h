#import <Foundation/Foundation.h>

#define INDEX(x, y) (y * 8 + x)

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
}
@property (nonatomic, readwrite, assign) PIECE *board;
@property (nonatomic, readwrite, assign) Coord from, to;
@property (nonatomic, readwrite, assign) int evaluation;
@property (nonatomic, readwrite, assign) int depth;
- (int)evaluate;
@end
