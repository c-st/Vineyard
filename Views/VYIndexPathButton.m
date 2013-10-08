//
//  VYIndexPathButton.m
//  Vineyard
//
//  Created by Christian Stangier on 29.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYIndexPathButton.h"

@implementation VYIndexPathButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
//		[self.layer setBorderWidth:0.0];
	//	[self.layer setCornerRadius:10.0];
	//	[[self layer] setMasksToBounds:YES];
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGRect frame = self.bounds;
	
	CGPathRef roundedRectPath = [self newPathForRoundedRect:frame radius:7];
	
	[[self tintColor] set];
	//[[UIColor blueColor] set];
	
	CGContextAddPath(ctx, roundedRectPath);
	CGContextFillPath(ctx);
	
	CGPathRelease(roundedRectPath);
}


- (CGPathRef) newPathForRoundedRect:(CGRect)rect radius:(CGFloat)radius {
	CGMutablePathRef retPath = CGPathCreateMutable();
	
	CGRect innerRect = CGRectInset(rect, radius, radius);
	
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;
	
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
	
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
	
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
	
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
	
	CGPathCloseSubpath(retPath);
	
	return retPath;
}
@end
