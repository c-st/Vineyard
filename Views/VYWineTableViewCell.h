//
//  VYWineTableViewCell.h
//  Vineyard
//
//  Created by Christian Stangier on 02.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wine.h"
#import "Region.h"
#import "Country.h"
#import "Appellation.h"
#import "EDStarRating.h"


@interface VYWineTableViewCell : UITableViewCell {
	
}
@property (weak, nonatomic) IBOutlet UIImageView *wineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (weak, nonatomic) IBOutlet EDStarRating *wineStarRating;
@property (weak, nonatomic) IBOutlet UILabel *wineTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *appellationLabel;
@property (weak, nonatomic) IBOutlet UILabel *vintageLabel;

@property (weak, nonatomic) Wine *wine;

- (void) updateViewFromWine;
@end
