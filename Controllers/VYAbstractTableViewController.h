//
//  VYAbstractTableViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Wine.h"

@interface VYAbstractTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (void) updateAndRefetch;
@end
