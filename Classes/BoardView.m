#import "BoardView.h"
#import "Piece.h"
#import "Board.h"
#import "Location.h"
#import <QuartzCore/QuartzCore.h>
#import "TackViewController.h"

@implementation BoardView

@synthesize model;

@synthesize controller = _controller;

- (void)awakeFromNib {
    CGFloat green[] = { 0.0, 0.3, 0.0, 1.0 };
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    self.layer.backgroundColor = CGColorCreate(space, green);
}

- (CGColorRef)red {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat rgba[] = { 0.7, 0.0, 0.0, 1.0 };
    return CGColorCreate(space, rgba);
}    

- (CGColorRef)blue {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat rgba[] = { 0.0, 0.0, 0.7, 1.0 };
    return CGColorCreate(space, rgba);
}

- (void)refreshBoardView {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGSize size = [self bounds].size;
    cellSize = CGSizeMake(size.width / board.columns, size.height / board.rows);
    
    id player = nil; // hack hack hack.
    
    for (int r = 0; r < model.rows; r++) {
        for (int c = 0; c < model.columns; c++) {
            Location *loc = [[Location alloc] initWithColumn:c row:r];
            CALayer *cell = [board pieceAtLocation:loc];
            if (!cell) {
                cell = [CALayer layer];
                cell.name = [loc description];

                CGFloat cellColour[] = { 0.0, 0.0, 0.0, 0.3 * ((c + r) & 1) };
                cell.backgroundColor = CGColorCreate(space, cellColour);
                
                [self.layer addSublayer:cell];
                [board setPiece:cell atLocation:loc];
            }
            
            // Refresh the frame, in case our dimensions have changed.
            // May not be necessary, since we're in iPhone and dimensions cannot change...
            // But let's roll with it.
            cell.frame = CGRectMake(cellSize.width * c,
                                    cellSize.height * r,
                                    cellSize.width,
                                    cellSize.height);


            Piece *piece = [model pieceAtLocation:loc];
            if (piece) {
                CALayer *uiPiece = [CALayer layer];
                uiPiece.name = [piece description];
                [uiPiece setValue:piece forKey:@"underlyingPiece"];
                                
                if (!player)
                    player = piece.owner;
                uiPiece.backgroundColor = player == piece.owner ? [self red] : [self blue];
                uiPiece.frame = CGRectInset(cell.bounds, 8, 8);
                
                [cell.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
                [cell addSublayer: uiPiece];
            }
            
        }
    }
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];    
    CGPoint point = [touch locationInView:self];
    Location *loc = [Location locationWithColumn:(int)(point.x / cellSize.width)
                                             row:(int)(point.y / cellSize.height)];
    
    [_controller clickAtLocation:loc];    
}

- (void)setModel:(Board*)newModel {
    if ([model isEqual:newModel]) {
        NSLog(@"New model is identical to existing.");
        return;
    }
    
    [model autorelease];
    model = [newModel copy];
    
    if (!board) {
        NSLog(@"initially creating board for holding CALayers");
        board = [[Board alloc] initWithColumns:model.columns
                                          rows:model.rows];
    }

    [self refreshBoardView];
}


@end
