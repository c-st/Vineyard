//
//  VYAddWineViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Wine.h"
#import "Appellation.h"
#import "Country.h"
#import "Location.h"

@interface VYAddWineViewController : UITableViewController <CLLocationManagerDelegate> {
//	CLLocationManager *locationManager;
	
}

@property (atomic) BOOL newWine;
@property (nonatomic) Wine* wine;

- (void) setWineForEditing:(Wine *)theWine;
@end
