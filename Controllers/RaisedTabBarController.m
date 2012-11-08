#import "RaisedTabBarController.h"
#import "CountryTableViewController.h"
#import "AddWineViewController.h"

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
	NSLog(@"add wine pressed");

	AddWineViewController *addWineViewController = [[AddWineViewController alloc] init];
	UINavigationController *testNC = [[UINavigationController alloc] initWithRootViewController:addWineViewController];
	[[testNC navigationBar] setTintColor:[UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f]];
	
	UIBarButtonItem *cancelButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStylePlain target: self action: @selector(closeWineView:)];

	[[addWineViewController navigationItem] setLeftBarButtonItem:cancelButton];
	
	
	[self presentViewController:testNC animated:YES completion:nil];
}

-(void) closeWineView:(id *) sender {
	NSLog(@"close");
	
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	// 49 53 76
	// 111 60 77 rot
	// 134 143 189
	
	// 111 23 54
	
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:[[CountryTableViewController alloc] init]];
	
	[countryNavController.navigationBar setTintColor:[UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f]];
	
	[self setViewControllers:[NSArray arrayWithObjects:
                            countryNavController,
                            [self viewControllerWithTabTitle:@"Browse" image:[UIImage imageNamed:@"tab-explore"]],
                            [self viewControllerWithTabTitle:@"Add" image:nil],
                            [self viewControllerWithTabTitle:@"Collections" image:[UIImage imageNamed:@"tab-friends.png"]],
                            [self viewControllerWithTabTitle:@"Settings" image:[UIImage imageNamed:@"tab-me.png"]], nil]];
	
	[self addCenterButtonWithImage:[UIImage imageNamed:@"add-wine-button.png"] highlightImage:nil];
	
}

@end
