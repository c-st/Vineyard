#import "RaisedTabBarController.h"
#import "CountryTableViewController.h"
#import "AddWineViewController.h"
#import "WineTableViewController.h"
#import "Country.h"

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
	button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
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
	[[testNC navigationBar] setTintColor:[UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f]];
	
	UIBarButtonItem *cancelButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStylePlain target:addWineViewController action: @selector(closeWineView:)];
	[[addWineViewController navigationItem] setLeftBarButtonItem:cancelButton];
	
	UIBarButtonItem *saveButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Save" style: UIBarButtonItemStyleDone target:addWineViewController action: @selector(saveWine)];
	[[addWineViewController navigationItem] setRightBarButtonItem:saveButton];
	
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
	
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTableViewController];
	
	// Wines
	NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name.length > 0"];
    NSFetchedResultsController *winesController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:predicateName groupBy:nil delegate:nil];
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:winesController];
	[winesController setDelegate:wineTableViewController];
	[wineTableViewController setTitle:@"All wines"];
	UINavigationController *wineNavController = [[UINavigationController alloc] initWithRootViewController:wineTableViewController];
	
	// ...
	
	[countryNavController.navigationBar setTintColor:[UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f]];
	[wineNavController.navigationBar setTintColor:[UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f]];
	
	[self setViewControllers:[NSArray arrayWithObjects:
							wineNavController,
                            countryNavController,
                            [self viewControllerWithTabTitle:@"Add" image:nil],
                            [self viewControllerWithTabTitle:@"Collections" image:[UIImage imageNamed:@"tab-friends.png"]],
                            [self viewControllerWithTabTitle:@"Settings" image:[UIImage imageNamed:@"tab-me.png"]], nil]];
	
	[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
	
}

@end
