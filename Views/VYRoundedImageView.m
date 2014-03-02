//
//  VYRoundedImageView.m
//  Vineyard
//
//  Created by Christian Stangier on 02.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYRoundedImageView.h"

@implementation VYRoundedImageView

- (void) initialize {
	self.opaque = NO;
	self.layer.cornerRadius = self.frame.size.width / 2;
	self.layer.masksToBounds = YES;
}

- (id) initWithCoder:(NSCoder *)aCoder{
    if (self = [super initWithCoder:aCoder]){
        		[self initialize];
    }
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
    {
		[self initialize];
    }
    return self;
}




@end
