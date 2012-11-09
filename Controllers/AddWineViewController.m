//
//  AddWineViewController.m
//  Cellar
//
//  Created by Christian Stangier on 08.11.12.
//  Copyright (c) 2012 Christian Stangier. All rights reserved.
//

#import "AddWineViewController.h"

#import "AddWineTableViewController.h"

@interface AddWineViewController ()

@end

@implementation AddWineViewController


-(void) loadView {
	[super loadView];
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bound.origin.x,
																			  bound.origin.y,
																			  bound.size.width,
																			  bound.size.height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
	[scrollView setContentOffset: CGPointMake(0, 0)];
	
	[scrollView setContentInset:UIEdgeInsetsMake(21.0,0,0,0.0)];
	// 234 227 217
	[scrollView setBackgroundColor:[UIColor colorWithRed:(234.0f/255.0f) green:(227.0f/255.0f) blue:(217.0f/255.0f) alpha:1.0f]];
	scrollView.showsVerticalScrollIndicator=NO;
	scrollView.scrollEnabled=YES;
	scrollView.userInteractionEnabled=YES;
	
	UILabel *label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(10, -100, bound.size.width-20, 50)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:@"Snell Roundhand" size:13.0f]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setNumberOfLines:0];
	[label setText:@"Life is too short\n to drink bad wine"];
	[scrollView addSubview:label];
	
	AddWineTableViewController *tableView = [[AddWineTableViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
	[scrollView addSubview:tableView.view];
	
	[self.view addSubview:scrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self setTitle:@"Add a Wine"];
	//[self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
