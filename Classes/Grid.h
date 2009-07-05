#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Board;
@class TackViewController;

@interface Grid : UIView {
    TackViewController *_controller;
    Board *_board;
    CGSize cellSize;
}

@property (retain) Board *board;
@property (retain) TackViewController *controller;

- (void)createGrid;

@end
