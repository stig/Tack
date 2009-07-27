#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBLayer.h"

@class Board;
@class TackViewController;

@interface BoardView : UIView {
    Board *model;
    Board *cells;
    SBLayer *activeCell;
    
    TackViewController *_controller;
    CGSize cellSize;
}

@property(retain) Board *model;

@property (retain) TackViewController *controller;

- (void)createCells;

@end
