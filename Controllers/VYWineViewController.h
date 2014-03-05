//
//  VYWineViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 23.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "SwipeView.h"
#import "EDStarRating.h"
#import "VYScrollView.h"
#import "VYAddEditWineViewController.h"
#import "Wine.h"
#import "Location.h"


@interface VYWineViewController : UIViewController <UIScrollViewDelegate, VYScrollViewDelegate, SwipeViewDelegate, SwipeViewDataSource>

@property (nonatomic) Wine* wine;

@property (nonatomic) CLLocationCoordinate2D centerLocation;
@property (nonatomic) CLLocationDegrees deltaLatitudeFor1px;

@end
