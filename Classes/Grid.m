#import "Grid.h"
#import "Board.h"
#import <QuartzCore/QuartzCore.h>
#import "TackViewController.h"

@implementation Grid

@synthesize board = _board;
@synthesize controller = _controller;

- (void)awakeFromNib {
    CGFloat green[] = { 0.0, 0.3, 0.0, 1.0 };
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    self.layer.backgroundColor = CGColorCreate(space, green);
}

- (void)createGrid {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGSize size = [self bounds].size;
    cellSize = CGSizeMake(size.width / _board.columns, size.height / _board.rows);
    
    for (int r = 0; r < self.board.rows; r++) {
        for (int c = 0; c < self.board.columns; c++) {
            CALayer *cell = [self.board pieceAtColumn:c row:r];
            if (!cell) {
                cell = [CALayer layer];
                cell.name = [NSString stringWithFormat:@"cell%u%u", c, r];
                [self.layer addSublayer: cell];
            }
            
            CGFloat cellColour[] = { 0.0, 0.0, 0.0, 0.3 * ((c + r) & 1) };
            cell.backgroundColor = CGColorCreate(space, cellColour);
            
            cell.frame = CGRectMake(cellSize.width * c,
                                    cellSize.height * r,
                                    cellSize.width,
                                    cellSize.height);

            [_board setPiece:cell atColumn:c row:r];
        }
    }
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];    
    CGPoint point = [touch locationInView:self];    
    [_controller clickInColumn:(int)(point.x / cellSize.width)
                           row:(int)(point.y / cellSize.height)];
    
}

@end
