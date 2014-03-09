//
//  VYTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 09.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYTableViewController.h"

@interface VYTableViewController ()

@end

@implementation VYTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    // Custom navigation item title view
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];
    label.text = self.navigationItem.title;
	[[self navigationItem] setTitleView:label];
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

@end
