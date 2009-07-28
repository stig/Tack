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

- (CGColorRef)yellow {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat rgba[] = { 0.7, 0.7, 0.0, 1.0 };
    return CGColorCreate(space, rgba);
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

- (void)createCells {
    
    [cells release];
    cells = [[Board alloc] initWithColumns:model.columns
                                      rows:model.rows];
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGSize size = [self bounds].size;
    cellSize = CGSizeMake(size.width / cells.columns, size.height / cells.rows);
    
    for (int r = 0; r < model.rows; r++) {
        for (int c = 0; c < model.columns; c++) {
            Location *loc = [[Location alloc] initWithColumn:c row:r];
            SBLayer *cell = [cells pieceAtLocation:loc];
            if (!cell) {
                cell = [SBLayer layer];
                cell.name = [loc description];
                cell.cornerRadius = 4;
                [cell setValue:loc forKey:@"cellLocation"];

                CGFloat cellColour[] = { 0.0, 0.0, 0.0, 0.3 * ((c + r) & 1) };
                cell.backgroundColor = CGColorCreate(space, cellColour);
                cell.borderColor = [self yellow];
                
                [self.layer addSublayer:cell];
                [cells setPiece:cell atLocation:loc];
            }
            
            // Refresh the frame, in case our dimensions have changed.
            // May not be necessary, since we're in iPhone and dimensions cannot change...
            // But let's roll with it.
            cell.frame = CGRectMake(cellSize.width * c,
                                    cellSize.height * r,
                                    cellSize.width,
                                    cellSize.height);
            
        }
    }
}

# pragma mark Touches

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    NSLog(@"touchesBegan:withEvent:");
    UITouch *touch = [touches anyObject];    
    CGPoint point = [touch locationInView:nil];    
    CALayer *cell = [self.layer hitTest:point];

    if (cell && [cell isKindOfClass:[SBLayer class]]) {
        activeCell = (SBLayer*)cell;
        activeCell.borderWidth = 2;
        activeCell.scale = 1.4;
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    NSLog(@"touchesMoved:withEvent:");
    UITouch *touch = [touches anyObject];    
    CGPoint point = [touch locationInView:nil];
    if (activeCell) {
        activeCell.borderWidth = 0;
        activeCell.scale = 1.0;
    }
    
    CALayer *cell = [self.layer hitTest:point];
    if (cell && [cell isKindOfClass:[SBLayer class]]) {
        activeCell = (SBLayer*)cell;
        activeCell.borderWidth = 2;
        activeCell.scale = 1.4;
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];    
    CGPoint point = [touch locationInView:nil];    
    CALayer *layer = [self.layer hitTest:point];
    
    Location *loc = [layer valueForKey:@"cellLocation"];
    if (loc)
        [_controller clickAtLocation:loc];
    else if ([layer valueForKey:@"underlyingPiece"])
        NSLog(@"Cell already occupied!");
    else
        NSLog(@"Did not hit a cell layer!");
    activeCell.borderWidth = 0;
    activeCell.scale = 1.0;
    activeCell = nil;
}


- (void)setModel:(Board*)newModel {

    if (model)
        [model removeObserver:self];
    
    [model autorelease];
    model = [newModel retain];

    [self createCells];
    
    [newModel addObserver:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{    
    static Player *player = nil;
    
    CALayer *cell = [cells pieceAtLocation:context];
    Piece *piece = [object pieceAtLocation:context];
    if (piece) {        
        CALayer *uiPiece = [CALayer layer];
        uiPiece.name = [piece description];
        [uiPiece setValue:piece forKey:@"underlyingPiece"];
        
        if (!player)
            player = piece.owner;
        CGColorRef colour = player == piece.owner ? [self red] : [self blue];
        uiPiece.backgroundColor = colour;
        CGColorRelease(colour);
        uiPiece.frame = CGRectInset(cell.bounds, 8, 8);
        uiPiece.cornerRadius = uiPiece.bounds.size.width / 2.0;
        
        CALayer *old = [cell.sublayers lastObject];
        if (old)
            [cell replaceSublayer:old with:uiPiece];
        else
            [cell addSublayer: uiPiece];
    } else {
        [cell.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    
}


@end
