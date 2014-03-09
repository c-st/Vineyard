//
//  VYTintedImageTableViewCell.m
//  Vineyard
//
//  Created by Christian Stangier on 09.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYTintedImageTableViewCell.h"

@implementation VYTintedImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [self.cellImage setImage:[self.cellImage.image rt_tintedImageWithColor:[self tintColor]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
