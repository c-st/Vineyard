//
//  AbstractTableViewController.h
//  Cellar
//
//  Created by Christian Stangier on 07.11.12.
//  Copyright (c) 2012 Christian Stangier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

@end
