//
//  MainView.m
//  Pegs
//
//  Created by Peter Wansch on 7/23/13.
//
//

#import "MainView.h"

@interface MainView ()

- (CGRect)statusBarFrameViewRect;
- (CGRect)textFrame;

@end

@implementation MainView

@synthesize board;

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder]))
	{
        // Initialization code
        self.text = nil;
        self.grabbedPeg = [[PegView alloc] initWithFrame:[self boardRect:0 :0]];
        self.grabbedPeg.hidden = YES;
        [self addSubview:self.grabbedPeg];
        
        // Set the background color
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.5f blue:0.0f alpha:1.0f];
	}
    return self;
}

// Custom drawing
- (void)drawRect:(CGRect)rect
{
    CGRect rectPaint;
    
	// Obtain graphics context and set defaults
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    UIFont *font;
    CGFloat inset;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        font = [UIFont systemFontOfSize:14];
        inset = INSET_IPHONE;
    } else {
        font = [UIFont systemFontOfSize:28];
        inset = INSET_IPAD;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dictionaryWhite = @{NSFontAttributeName: font,  NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor whiteColor]};
    
	// Calculate block size, starting point and offset
    CGRect statusBarFrame = [self statusBarFrameViewRect];
    CGFloat NOPOINTS = MIN(self.bounds.size.width / DIVISIONS, (self.bounds.size.height - statusBarFrame.size.height) / DIVISIONS);
    CGPoint ptlOffset = CGPointMake((self.bounds.size.width - (DIVISIONS * NOPOINTS)) / 2, (self.bounds.size.height - (DIVISIONS * NOPOINTS)) / 2);
    
    // drawing board
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    for (short x = 0; x < DIVISIONS; x++) {
        for (short y = 0; y < DIVISIONS; y++) {
            if (self.board.fState[x][y] > EMPTY)
            {
                rectPaint = [self boardRect:x :y];
                if (CGRectIntersectsRect(rectPaint, rect)) {
                    // Draw board background
                    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
                    CGContextAddRect(context, rectPaint);
                    CGContextDrawPath(context, kCGPathFillStroke);
                    // Draw board or piece
                    rectPaint.origin.x += inset;
                    rectPaint.origin.y += inset;
                    rectPaint.size.width -= inset * 2;
                    rectPaint.size.height -= inset * 2;
                    if (self.board.fState[x][y] == BOARD) {
                        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
                        CGContextAddEllipseInRect(context, rectPaint);
                        CGContextDrawPath(context, kCGPathFill);
                    } else if (self.board.fState[x][y] == PIECE) {
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
                }
            }
        }
    }
    
    // Draw borders
    CGFloat offset = NOPOINTS / 8;
	
    // Draw borders and shadows in region 0
	CGPoint pointBorder[4];
    pointBorder[0].x = ptlOffset.x + NOPOINTS;
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + NOPOINTS + offset;
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
    pointBorder[2].x = ptlOffset.x + (3 * NOPOINTS);
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
    pointBorder[3].x = ptlOffset.x + (3 * NOPOINTS);
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[1].x + offset, pointBorder[1].y, (2 * NOPOINTS) - (2 * offset), offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}
    
    // draw borders and shadows in region 1
    pointBorder[0].x = ptlOffset.x + (3 * NOPOINTS);
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + (3 * NOPOINTS) + offset;
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS + offset;
    pointBorder[2].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS + offset;
    pointBorder[3].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[1].x + offset, pointBorder[1].y, (3 * NOPOINTS), offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}
    
    // draw borders and shadows in region 2
    pointBorder[0].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS;
    pointBorder[2].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 1) * NOPOINTS + offset;
    pointBorder[3].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[3].x, pointBorder[3].y, offset, (2 * NOPOINTS));
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}
    
    // draw borders and shadows in region 3
    pointBorder[0].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
    pointBorder[2].x = ptlOffset.x + (8 * NOPOINTS) + offset;
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
    pointBorder[3].x = ptlOffset.x + (8 * NOPOINTS);
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[1].x + offset, pointBorder[1].y, (2 * NOPOINTS), offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}
    
    // draw borders and shadows in region 4
    pointBorder[0].x = ptlOffset.x + (8 * NOPOINTS);
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 6) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + (8 * NOPOINTS);
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS;
    pointBorder[2].x = ptlOffset.x + (8 * NOPOINTS) + offset;
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 3) * NOPOINTS + offset;
    pointBorder[3].x = ptlOffset.x + (8 * NOPOINTS) + offset;
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 6) * NOPOINTS + offset;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[3].x, pointBorder[3].y + offset, offset, (3 * NOPOINTS));
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}
    
    // draw borders and shadows in region 5
    pointBorder[0].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[0].y = ptlOffset.y + (DIVISIONS - 8) * NOPOINTS;
    pointBorder[1].x = ptlOffset.x + (6 * NOPOINTS);
    pointBorder[1].y = ptlOffset.y + (DIVISIONS - 6) * NOPOINTS;
    pointBorder[2].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[2].y = ptlOffset.y + (DIVISIONS - 6) * NOPOINTS;
    pointBorder[3].x = ptlOffset.x + (6 * NOPOINTS) + offset;
    pointBorder[3].y = ptlOffset.y + (DIVISIONS - 8) * NOPOINTS + offset;
	rectPaint = CGRectMake(pointBorder[0].x, pointBorder[0].y, DIVISIONS * NOPOINTS + offset, offset);
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
		CGContextAddLines(context, pointBorder, 4);
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	rectPaint = CGRectMake(pointBorder[3].x, pointBorder[3].y + offset, offset, (2 * NOPOINTS) - (2 * offset));
	if (CGRectIntersectsRect(rectPaint, rect)) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
		CGContextAddRect(context, rectPaint);
		CGContextDrawPath(context, kCGPathFill);
	}

    // Ausgabetext zeichnen
    if (self.text != nil && [self.text length] > 0) {
        rectPaint = [self textFrame];
        if (CGRectIntersectsRect(rectPaint, rect)) {
            [self.text drawInRect:rectPaint withAttributes:dictionaryWhite];
        }
    }
}

- (CGRect)textFrame
{
    CGRect statusBarFrame = [self statusBarFrameViewRect];
    CGFloat NOPOINTS = MIN(self.bounds.size.width / DIVISIONS, (self.bounds.size.height - statusBarFrame.size.height) / DIVISIONS);
    CGPoint ptlOffset = CGPointMake((self.bounds.size.width - (DIVISIONS * NOPOINTS)) / 2, (self.bounds.size.height - (DIVISIONS * NOPOINTS)) / 2);
    UIFont *font;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        font = [UIFont systemFontOfSize:14];
    } else {
        font = [UIFont systemFontOfSize:28];
    }
    return CGRectMake(0, statusBarFrame.size.height + (ptlOffset.y + NOPOINTS - statusBarFrame.size.height - font.pointSize * 2) / 2, self.bounds.size.width, font.pointSize * 2);
}

- (void)invalidateText
{
    [self setNeedsDisplayInRect:[self textFrame]];
}

- (CGRect)boardRect:(short)x :(short)y {
	// Calculate block size, starting point and offset
    CGRect statusBarFrame = [self statusBarFrameViewRect];
    CGFloat NOPOINTS = MIN(self.bounds.size.width / DIVISIONS, (self.bounds.size.height - statusBarFrame.size.height) / DIVISIONS);
    CGPoint ptlOffset = CGPointMake((self.bounds.size.width - (DIVISIONS * NOPOINTS)) / 2, (self.bounds.size.height - (DIVISIONS * NOPOINTS)) / 2);
	return CGRectMake(ptlOffset.x + (x * NOPOINTS), ptlOffset.y + ((DIVISIONS - y - 1) * NOPOINTS), NOPOINTS, NOPOINTS);
}

- (short)getTouchXIndex:(NSSet *)touches
{
    // Get touch position
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
    
	// Calculate block size, starting point and offset
    CGRect statusBarFrame = [self statusBarFrameViewRect];
    CGFloat NOPOINTS = MIN(self.bounds.size.width / DIVISIONS, (self.bounds.size.height - statusBarFrame.size.height) / DIVISIONS);
    CGPoint ptlOffset = CGPointMake((self.bounds.size.width - (DIVISIONS * NOPOINTS)) / 2, (self.bounds.size.height - (DIVISIONS * NOPOINTS)) / 2);

    if (point.x < ptlOffset.x) {
        return -1;
    }
    
    return ((point.x - ptlOffset.x) / NOPOINTS);
}

- (short)getTouchYIndex:(NSSet *)touches
{
    // Get touch position
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
    
	// Calculate block size, starting point and offset
    CGRect statusBarFrame = [self statusBarFrameViewRect];
    CGFloat NOPOINTS = MIN(self.bounds.size.width / DIVISIONS, (self.bounds.size.height - statusBarFrame.size.height) / DIVISIONS);
    CGPoint ptlOffset = CGPointMake((self.bounds.size.width - (DIVISIONS * NOPOINTS)) / 2, (self.bounds.size.height - (DIVISIONS * NOPOINTS)) / 2);
    
    if (point.y < ptlOffset.y) {
        return -1;
    }
    return (DIVISIONS - ((point.y - ptlOffset.y) / NOPOINTS));
}

- (CGRect)statusBarFrameViewRect
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect statusBarWindowRect = [self.window convertRect:statusBarFrame fromWindow: nil];
    CGRect statusBarViewRect = [self convertRect:statusBarWindowRect fromView: nil];
    return statusBarViewRect;
}

- (PBoard)getBoardPointer {
    return &board;
}

@end
