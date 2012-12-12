#import "UIColor+CellarColours.h"

#import "RaisedTabBarController.h"
#import "CountryTableViewController.h"
#import "AddWineViewController.h"
#import "WineTableViewController.h"
#import "VarietalTableViewController.h"
#import "Country.h"

#import "PaperFoldView.h"
#import "PaperFoldNavigationController.h"

#import "RightWineFoldViewController.h"


@implementation RaisedTabBarController

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image {
	UIViewController* viewController = [[UIViewController alloc] init];
	viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
	return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage {
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.autoresizingMask = UIViewAutoresizingNone;
	button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height); 
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	//[button setBackgroundColor:[UIColor redColor]];
	[button addTarget:self action:@selector(addWineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
	if (heightDifference < 0) {
		button.center = self.tabBar.center;
	} else {
		CGPoint center = self.tabBar.center;
		center.y = center.y - heightDifference/2.0;
		button.center = center;
	}
	
	[self.view addSubview:button];
}

-(void) addWineButtonPressed:(id *) sender {
	AddWineViewController *addWineViewController = [[AddWineViewController alloc] init];
	UINavigationController *testNC = [[UINavigationController alloc] initWithRootViewController:addWineViewController];
	[[testNC navigationBar] setTintColor:[UIColor cellarWineRedColour]];
	
	[self presentViewController:testNC animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	
	// Construct the view controllers
	
	// 1. Tabs
	
	// 1.1 Wines
	WineTableViewController *wineTVC = [[WineTableViewController alloc] init];
	[wineTVC setTitle:@"Wines"];
	wineTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0];
	
	// 1.1.0 Content
	UINavigationController *wineNavController = [[UINavigationController alloc] initWithRootViewController:wineTVC];
	PaperFoldNavigationController *winePaperFoldNC = [[PaperFoldNavigationController alloc] initWithRootViewController:wineNavController];
	[winePaperFoldNC.paperFoldView setBackgroundColor:[UIColor blackColor]];
	winePaperFoldNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0];
//	[[winePaperFoldNC paperFoldView] setEnableLeftFoldDragging:NO];
	
	// 1.1.1 Left view (dummy)
	UIViewController *dummyVC = [[UIViewController alloc] init];
	[dummyVC.view setFrame:CGRectMake(0, 0, 100, [self.view bounds].size.height)];
	[dummyVC.view setBackgroundColor:[UIColor greenColor]];
	[winePaperFoldNC setLeftViewController:dummyVC width:100.0];
	
	// 1.1.2 Right view
	RightWineFoldViewController *wineRightVC = [[RightWineFoldViewController alloc] init];
	[wineRightVC.view setFrame:CGRectMake(0, 0, 150, [self.view bounds].size.height)];
	[winePaperFoldNC setRightViewController:wineRightVC width:150 rightViewFoldCount:1 rightViewPullFactor:1.0];
	
	
	// 1.2 Countries
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	
	[countryTVC setTitle:@"Countries"];
	[countryTVC setShowCount:YES];
	countryTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Countries" image:[UIImage imageNamed:@"globe-icon.png"] tag:0];
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTVC];
	
	
	// 1.3 Varietals
	VarietalTableViewController *varietalTVC = [[VarietalTableViewController alloc] init];
	[varietalTVC setTitle:@"Varietals"];
	[varietalTVC setShowCount:YES];
	[varietalTVC setPickMode:NO];
	varietalTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Varietals" image:[UIImage imageNamed:@"food_grapes.png"] tag:0];
	UINavigationController *varietalNavController = [[UINavigationController alloc] initWithRootViewController:varietalTVC];
	
	
	// 1.3 Collections
	UIViewController *collectionsVC = [[UIViewController alloc] init];
	[collectionsVC setTitle:@"Collections"];
	[collectionsVC.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	// 1.3.0 Content
	UINavigationController *collectionsNavController = [[UINavigationController alloc] initWithRootViewController:collectionsVC];
	PaperFoldNavigationController *paperFoldNavController = [[PaperFoldNavigationController alloc] initWithRootViewController:collectionsNavController];
	paperFoldNavController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"collections.png"] tag:0];
	[[paperFoldNavController paperFoldView] setEnableLeftFoldDragging:NO];
	
	// 1.3.1 Left view (dummy)
	UIViewController *dummy2VC = [[UIViewController alloc] init];
	[dummy2VC.view setFrame:CGRectMake(0, 0, 100, [self.view bounds].size.height)];
	[dummy2VC.view setBackgroundColor:[UIColor greenColor]];
	[paperFoldNavController setLeftViewController:dummy2VC width:100.0];
	
	// 1.3.2 Right view
	UIViewController *rightVC = [[UIViewController alloc] init];
	[rightVC.view setFrame:CGRectMake(0, 0, 150, [self.view bounds].size.height)];
	[rightVC.view setBackgroundColor:[UIColor grayColor]];
	[paperFoldNavController setRightViewController:rightVC width:150 rightViewFoldCount:3 rightViewPullFactor:1.0];
	
	
	
	// 2.
	[wineNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[countryNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[varietalNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[collectionsNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	
	[self setViewControllers:[NSArray arrayWithObjects:
							winePaperFoldNC,
                            countryNavController,
                            [self viewControllerWithTabTitle:@"Add" image:nil],
                            varietalNavController,
                            paperFoldNavController, nil]];
	
	[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
}

@end
