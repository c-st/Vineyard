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

#import "InitialDataImportService.h"


@implementation RaisedTabBarController

// Create a view controller and setup its tab bar item with a title and image
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

- (PaperFoldNavigationController*) createPaperFoldNavControllerForRootViewController:(AbstractTableViewController*) rootViewController andTabBarItem:(UITabBarItem*) tabBarItem {
	[rootViewController setTabBarItem:tabBarItem];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
	[navigationController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	PaperFoldNavigationController *paperFoldNavigationController = [[PaperFoldNavigationController alloc] initWithRootViewController:navigationController];
	[paperFoldNavigationController.paperFoldView setBackgroundColor:[UIColor blackColor]];
	[paperFoldNavigationController setTabBarItem:tabBarItem];
	[rootViewController setPaperFoldNC:paperFoldNavigationController];
	
	// dummy
	UIViewController *dummyVC = [[UIViewController alloc] init];
	[dummyVC.view setFrame:CGRectMake(0, 0, 150, [self.view bounds].size.height)];
	[dummyVC.view setBackgroundColor:[UIColor blackColor]];
	
	// map fold view c
	WineMapFoldViewController *mapFoldViewController = [[WineMapFoldViewController alloc] init];
	[mapFoldViewController.view setFrame:CGRectMake(0, 0, 275, [self.view bounds].size.height)];
	[mapFoldViewController.view setBackgroundColor:[UIColor blackColor]];
	
	[paperFoldNavigationController setRightViewController:mapFoldViewController width:275 rightViewFoldCount:2 rightViewPullFactor:1.0];
	[paperFoldNavigationController setLeftViewController:dummyVC width:100];
	
	[[paperFoldNavigationController paperFoldView] setEnableRightFoldDragging:NO];
	[[paperFoldNavigationController paperFoldView] setEnableLeftFoldDragging:NO];
	
	return paperFoldNavigationController;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	
	// Wines (Paperfold)
	WineTableViewController *wineTVC = [[WineTableViewController alloc] init];
	[wineTVC setTitle:@"Wines"];
	PaperFoldNavigationController *winePaperFoldNC = [self createPaperFoldNavControllerForRootViewController:wineTVC
																							   andTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0]];
	// Browse (Paperfold)
	BrowseTableViewController *browseTVC = [[BrowseTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[browseTVC setTitle:@"Browse"];
	[browseTVC setShowCount:NO];
	[browseTVC setShowPieChart:NO];
	PaperFoldNavigationController *browsePaperFoldNC = [self createPaperFoldNavControllerForRootViewController:browseTVC
																							   andTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Browse" image:[UIImage imageNamed:@"browse.png"] tag:0]];
	
	// Collections
	// NSFetchedResultsController *collectionsFRC = [Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CollectionTableViewController *collectionsTVC = [[CollectionTableViewController alloc] initWithFetchedResultsController:nil];
	[collectionsTVC setTitle:@"Collections"];
	[collectionsTVC setShowCount:YES];
	[collectionsTVC setShowPieChart:NO];
	PaperFoldNavigationController *collectionPaperFoldNC = [self createPaperFoldNavControllerForRootViewController:collectionsTVC
																								 andTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"box.png"] tag:0]];
	
	// Countries // Food
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	[countryTVC setTitle:@"Food"];
	[countryTVC setShowCount:YES];
	[countryTVC setShowPieChart:YES];
	countryTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"plate.png"] tag:0];
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTVC];
	
	
	[self setViewControllers:@[winePaperFoldNC,
							browsePaperFoldNC,
                            //[self viewControllerWithTabTitle:@"" image:nil],
							collectionPaperFoldNC,
							//countryNavController, // food? characteristics?
                            ]];
	
	//[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
}

@end
