//
//  Cell.h
//  Tack
//
//  Created by Stig Brautaset on 26/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SBLayer : CALayer {
	BOOL highlighted;
}

@property(assign) CGFloat scale;

@property(getter=isHighlighted) BOOL highlighted;

@end
