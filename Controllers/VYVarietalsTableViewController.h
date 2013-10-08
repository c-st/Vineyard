//
//  VYVarietalsViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 08.10.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAbstractTableViewController.h"
#import "VYWineTableViewController.h"
#import "VYBrowseTableViewCell.h"

#import "Wine.h"
#import "Varietal.h"
#import "GrapeType.h"

@interface VYVarietalsTableViewController : VYAbstractTableViewController

@property (nonatomic, strong) NSMutableArray* selectedVarietals;


@end
