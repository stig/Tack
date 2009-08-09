//
//  Cell.m
//  Tack
//
//  Created by Stig Brautaset on 26/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "SBLayer.h"


@implementation SBLayer

@synthesize highlighted;

- (CGFloat)scale {
    NSNumber *scale = [self valueForKeyPath: @"transform.scale"];
    return scale.floatValue;
}

- (void)setScale:(CGFloat)scale {
    [self setValue: [NSNumber numberWithFloat: scale]
        forKeyPath: @"transform.scale"];
}

- (void)setHighlighted:(BOOL)highlighted_ {
	if (highlighted = highlighted_) {
		self.zPosition = 100;
		self.borderWidth = 2;
		
	} else {
		self.zPosition = 0;
		self.borderWidth = 0;
	}
}

@end
