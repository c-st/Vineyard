//
//  VYAddWineViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "VYCountryTableViewController.h"
#import "VYAppellationTableViewController.h"

#import "Wine.h"
#import "Appellation.h"
#import "Country.h"
#import "Location.h"
#import "GrapeType.h"

@interface VYAddEditWineViewController : UITableViewController <CLLocationManagerDelegate> {
	
}
@property (atomic) BOOL newWine;
@property (nonatomic) Wine* wine;

- (void) setWineForEditing:(Wine *)theWine;
@end
