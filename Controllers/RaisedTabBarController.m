#import "UIColor+CellarColours.h"

#import "RaisedTabBarController.h"
#import "CountryTableViewController.h"
#import "AddWineViewController.h"
#import "WineTableViewController.h"
#import "VarietalTableViewController.h"
#import "Country.h"

#import "PaperFoldView.h"
#import "PaperFoldNavigationController.h"


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
	
	// Countries
	NSFetchedResultsController *countriesController = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesController];
	[countryTableViewController setTitle:@"Countries"];
	[countryTableViewController setShowCount:YES];
	countryTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Countries" image:[UIImage imageNamed:@"globe-icon.png"] tag:0];
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTableViewController];
	
	// Wines
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] init];
	[wineTableViewController setTitle:@"Wines"];
	wineTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0];
	UINavigationController *wineNavController = [[UINavigationController alloc] initWithRootViewController:wineTableViewController];
	
	// Varietals
	VarietalTableViewController *varietalTableViewController = [[VarietalTableViewController alloc] init];
	[varietalTableViewController setTitle:@"Varietals"];
	[varietalTableViewController setShowCount:YES];
	[varietalTableViewController setPickMode:NO];
	varietalTableViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Varietals" image:[UIImage imageNamed:@"food_grapes.png"] tag:0];
	UINavigationController *varietalNavController = [[UINavigationController alloc] initWithRootViewController:varietalTableViewController];
	
	// -- Collections
	
    //[self.window setRootViewController:paperFoldNavController];
	
	UIViewController *collectionsController = [[UIViewController alloc] init];
	//[collectionsController.view setFrame:self.view.frame];
	[collectionsController setTitle:@"Collections"];
	[collectionsController.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	
	UINavigationController *collectionsNavController = [[UINavigationController alloc] initWithRootViewController:collectionsController];
	PaperFoldNavigationController *paperFoldNavController = [[PaperFoldNavigationController alloc] initWithRootViewController:collectionsNavController];
	paperFoldNavController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"collections.png"] tag:0];
	
	// Left view (dummy)
	UIViewController *leftVC = [[UIViewController alloc] init];
	[leftVC.view setFrame:CGRectMake(0,0,100,[self.view bounds].size.height)];
	[leftVC.view setBackgroundColor:[UIColor greenColor]];
	[paperFoldNavController setLeftViewController:leftVC width:150.0];
	
	// Right view
	UIViewController *rightVC = [[UIViewController alloc] init];
	[rightVC.view setFrame:CGRectMake(0,0,240,[self.view bounds].size.height)];
	[rightVC.view setBackgroundColor:[UIColor blueColor]];
	[paperFoldNavController setRightViewController:rightVC width:250.0 rightViewFoldCount:3 rightViewPullFactor:0.9];
	
	
	
	
	
	[wineNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[countryNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[varietalNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	[collectionsNavController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	[self setViewControllers:[NSArray arrayWithObjects:
							wineNavController,
                            countryNavController,
                            [self viewControllerWithTabTitle:@"Add" image:nil],
                            varietalNavController,
                            paperFoldNavController, nil]];
	
	[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
}

@end
