//
//  VYWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 23.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYWineViewController.h"

@interface VYWineViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation VYWineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//NSLog(@"self wine: %@", [self wine]);
	[[self navigationItem] setTitle:[[self wine] name]];
	
	[self.scrollView setDelegate:self];
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([self wine] != nil) {
		NSLog(@"VYWineTableViewContoller -> prepareForSeque. Pushing wine");
		//NSLog(@"%@", NSStringFromClass([[segue destinationViewController] class]));
		
		// pass data through
		if ([[[[segue destinationViewController] viewControllers] objectAtIndex:0]
			 isKindOfClass:[VYAddEditWineViewController class]]) {
			
			VYAddEditWineViewController *editWineViewController =
				[[[segue destinationViewController] viewControllers] objectAtIndex:0];
			
			NSLog(@"target is AddWineViewController. setting wine");
			[editWineViewController setWineForEditing:[self wine]];
		}
	}
}

#pragma mark
#pragma mark Scrolling
- (void)scrollViewDidScroll:(UIScrollView *)theScrollView {
	NSLog(@"scrolling");
}

@end
