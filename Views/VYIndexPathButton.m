//
//  VYIndexPathButton.m
//  Vineyard
//
//  Created by Christian Stangier on 29.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYIndexPathButton.h"

@implementation VYIndexPathButton

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
//		[self.layer setBorderWidth:0.0];
		[self.layer setCornerRadius:10.0];
		//[[self layer] setMasksToBounds:YES];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
