//
//  VYWineTableViewCell.m
//  Vineyard
//
//  Created by Christian Stangier on 02.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYWineTableViewCell.h"


@implementation VYWineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void) updateViewFromWine {
	//NSLog(@"building view for %@", self.wine);
	[self.wineTitleLabel setText:[self.wine name]];
	if ([self.wine country] != nil) {
		[self.flagImage setImage:[UIImage imageNamed:[self.wine.country.isoCode stringByAppendingString:@".png"]]];
	}
	if ([self.wine imageThumbnail] != nil) {
		[self.wineImageView setImage:[UIImage imageWithData:[self.wine imageThumbnail]]];
	}
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
