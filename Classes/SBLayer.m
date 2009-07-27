//
//  Cell.m
//  Tack
//
//  Created by Stig Brautaset on 26/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "SBLayer.h"


@implementation SBLayer

- (CGFloat)scale {
    NSNumber *scale = [self valueForKeyPath: @"transform.scale"];
    return scale.floatValue;
}

- (void)setScale:(CGFloat)scale {
    [self setValue: [NSNumber numberWithFloat: scale]
        forKeyPath: @"transform.scale"];
}

@end
