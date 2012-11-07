#import "RaisedTabBarController.h"
#import "CountryTableViewController.h"

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

// Build Tab
/*
- (*NSArray) buildViewControllerArray {
	UINavigationController *myNavigationController;
    
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    
    CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] init];
    [countryTableViewController setTitle:@"Wines"];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:countryTableViewController];
    [tabs addObject:myNavigationController];
    
    
    UIViewController *mySecondViewController = [[UIViewController alloc] init];
    [mySecondViewController setTitle:@"Browse"];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:mySecondViewController];
    [tabs addObject:myNavigationController];
    
    UIViewController *myThirdViewController = [[UIViewController alloc] init];
    [myThirdViewController setTitle:@"Add"];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:myThirdViewController];
    [tabs addObject:myNavigationController];
    
    UIViewController *myFourthViewController = [[UIViewController alloc] init];
    [myFourthViewController setTitle:@"Collections"];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:myFourthViewController];
    [tabs addObject:myNavigationController];
    
    UIViewController *myFithViewController = [[UIViewController alloc] init];
    [myFithViewController setTitle:@"Settings"];
    myNavigationController = [[UINavigationController alloc] initWithRootViewController:myFithViewController];
    [tabs addObject:myNavigationController];
    
    [tabBarController setViewControllers:tabs];
	
	return [NSArray arrayWithObjects:nil];
}
*/

- (void) viewDidLoad {
	[super viewDidLoad];
	
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:[[CountryTableViewController alloc] init]];
	
	
	[self setViewControllers:[NSArray arrayWithObjects:
                            countryNavController,
                            [self viewControllerWithTabTitle:@"Explore" image:[UIImage imageNamed:@"tab-explore"]],
                            [self viewControllerWithTabTitle:@"" image:nil],
                            [self viewControllerWithTabTitle:@"Friends" image:[UIImage imageNamed:@"tab-friends.png"]],
                            [self viewControllerWithTabTitle:@"Me" image:[UIImage imageNamed:@"tab-me.png"]], nil]];
	
}

-(void) willAppearIn:(UINavigationController *)navigationController {
	[self addCenterButtonWithImage:[UIImage imageNamed:@"DE.png"] highlightImage:nil];
}

@end
