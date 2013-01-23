#import "UIColor+CellarColours.h"

#import "RaisedTabBarController.h"
#import "BrowseTableViewController.h"
#import "CountryTableViewController.h"
#import "AddWineViewController.h"
#import "WineTableViewController.h"
#import "VarietalTableViewController.h"
#import "CollectionTableViewController.h"

#import "Country.h"
#import "Collection.h"

#import "PaperFoldView.h"
#import "PaperFoldNavigationController.h"

#import "WineMapFoldViewController.h"


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
	
	// Wines
	WineTableViewController *wineTVC = [[WineTableViewController alloc] init];
	[wineTVC setTitle:@"Wines"];
	wineTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0];

	UINavigationController *wineNavController = [[UINavigationController alloc] initWithRootViewController:wineTVC];
	PaperFoldNavigationController *winePaperFoldNC = [[PaperFoldNavigationController alloc] initWithRootViewController:wineNavController];
	[winePaperFoldNC.paperFoldView setBackgroundColor:[UIColor blackColor]];
	winePaperFoldNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0];
	[[winePaperFoldNC paperFoldView] setEnableRightFoldDragging:NO];
	[wineTVC setPaperFoldNC:winePaperFoldNC];
	
	UIViewController *dummyVC = [[UIViewController alloc] init];
	[dummyVC.view setFrame:CGRectMake(0, 0, 150, [self.view bounds].size.height)];
	[dummyVC.view setBackgroundColor:[UIColor blackColor]];
	
	WineMapFoldViewController *wineRightVC = [[WineMapFoldViewController alloc] init];
	[wineRightVC.view setFrame:CGRectMake(0, 0, 120, [self.view bounds].size.height)];
	
	[winePaperFoldNC setRightViewController:wineRightVC width:280 rightViewFoldCount:2 rightViewPullFactor:1.0];
	[winePaperFoldNC setLeftViewController:dummyVC width:100];
	
	// Browse
	// BrowseTableViewController
	BrowseTableViewController *browseTVC = [[BrowseTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[browseTVC setTitle:@"Browse"];
	[browseTVC setShowCount:NO];
	[browseTVC setShowPieChart:NO];
	
	browseTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Browse" image:[UIImage imageNamed:@"browse.png"] tag:0];
	UINavigationController *browseNavController = [[UINavigationController alloc] initWithRootViewController:browseTVC];
	// Paper fold
	
	
	// Countries
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	
	[countryTVC setTitle:@"Food"];
	[countryTVC setShowCount:YES];
	[countryTVC setShowPieChart:YES];
	countryTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"plate.png"] tag:0];
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTVC];
	
	
	
	
	// Collections
	// NSFetchedResultsController *collectionsFRC = [Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CollectionTableViewController *collectionsTCV = [[CollectionTableViewController alloc] initWithFetchedResultsController:nil];
	
	[collectionsTCV setTitle:@"Collections"];
	collectionsTCV.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"collections.png"] tag:0];
	UINavigationController *collectionsNavController = [[UINavigationController alloc] initWithRootViewController:collectionsTCV];

	
	// 2.
	[wineNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[browseNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[countryNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[collectionsNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	
	[self setViewControllers:@[winePaperFoldNC,
							browseNavController,
                            // varietalNavController,
                            [self viewControllerWithTabTitle:@"" image:nil],
							collectionsNavController,
							countryNavController, // food
                            ]];
	
	[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
}

@end
