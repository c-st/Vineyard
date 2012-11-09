//
//  AddWineViewController.m
//  Cellar
//
//  Created by Christian Stangier on 08.11.12.
//  Copyright (c) 2012 Christian Stangier. All rights reserved.
//

#import "AddWineViewController.h"

@interface AddWineViewController ()

@end

@implementation AddWineViewController


-(void) loadView {
	[super loadView];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100)];
	[scrollView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	scrollView.showsVerticalScrollIndicator=NO;
	scrollView.scrollEnabled=YES;
	scrollView.userInteractionEnabled=YES;
	
	UILabel *label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(20, 20, 100, 100)];
	[label setBackgroundColor:[UIColor redColor]];
	[label setText:@"Test"];
	[scrollView addSubview:label];
	
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
