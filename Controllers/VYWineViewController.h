//
//  VYWineViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 23.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VYAddEditWineViewController.h"
#import "Wine.h"


@interface VYWineViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) Wine* wine;

@end
