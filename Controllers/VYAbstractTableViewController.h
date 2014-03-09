//
//  VYAbstractTableViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VYTableViewController.h"
#import "Wine.h"

@interface VYAbstractTableViewController : VYTableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

// when navigating from 
@property (nonatomic) NSManagedObject *presetData;

@property (atomic) BOOL inPickerMode;

- (void) updateAndRefetch;

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object;
@end
