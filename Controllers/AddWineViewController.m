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
	
	// "Hidden" Label
	UILabel *label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(10, -100, bound.size.width-20, 50)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:@"Snell Roundhand" size:13.0f]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setNumberOfLines:0];
	[label setText:@"Life is too short\n to drink bad wine"];
	[scrollView addSubview:label];
	
	// Attribute Table
	AddWineTableViewController *tableView = [[AddWineTableViewController alloc] init];

	[tableView.tableView setDelegate:self];
	[tableView.tableView setDataSource:self];
	[scrollView addSubview:tableView.view];
	
	[self.view addSubview:scrollView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Cell for row");
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	//cell.textLabel.text = @"Hello";
	
	//
	//[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	switch (indexPath.item) {
		case 0:
			return [self buildTextCell];
			break;
			
		case 1:
			[cell.textLabel setText:@"Country"];
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			return cell;
			
		case 2:
			
			[cell.textLabel setText:@"Appellation"];
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			return cell;
			
		default:
			break;
	}
    
    return cell;
}



- (UITableViewCell *)buildTextCell {
	static NSString *CellIdentifier = @"TextInputCell";
	UITableViewCell *cell = nil; //[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
	UITextField *txtField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 320, 39)];
	txtField.autoresizingMask=UIViewAutoresizingFlexibleHeight;
	txtField.autoresizesSubviews=YES;
	//txtField.layer.cornerRadius=10.0;
	[txtField setBorderStyle:UITextBorderStyleNone];
	[txtField setPlaceholder:@"Name"];
	[cell.contentView addSubview:txtField];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	UIViewController *c = [[UIViewController alloc] init];
	[[self navigationController] pushViewController:c animated:YES];
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
