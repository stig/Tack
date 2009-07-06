#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Board;
@class TackViewController;

/// @todo rename to BoardView once refactoring works again...
@interface Grid : UIView {
    Board *model;
    Board *board;
    
    TackViewController *_controller;
    CGSize cellSize;
}

@property(retain) Board *model;

@property (retain) TackViewController *controller;

- (void)refreshBoardView;

@end
