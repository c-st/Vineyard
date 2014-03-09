//
//  VYBrowseTableViewCellCell.m
//  Vineyard
//
//  Created by Christian Stangier on 28.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYBrowseTableViewCell.h"

@implementation VYBrowseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
