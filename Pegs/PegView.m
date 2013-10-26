//
//  PegView.m
//  Pegs
//
//  Created by Peter Wansch on 10/20/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import "PegView.h"
#import "MainView.h"

@implementation PegView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	// Obtain graphics context and set defaults
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat inset;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        inset = INSET_IPHONE;
    } else {
        inset = INSET_IPAD;
    }
    CGRect rectPaint = self.bounds;
    rectPaint.origin.x += inset;
    rectPaint.origin.y += inset;
    rectPaint.size.width -= inset * 2;
    rectPaint.size.height -= inset * 2;
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetShadow(context, CGSizeMake(inset / 4, inset / 4), 4.0);
    CGContextAddEllipseInRect(context, rectPaint);
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    rectPaint.origin.x += inset / 2;
    rectPaint.origin.y += inset / 2;
    rectPaint.size.width = inset / 2;
    rectPaint.size.height = inset / 2;
    CGContextAddEllipseInRect(context, rectPaint);
    CGContextDrawPath(context, kCGPathFill);
}

@end
