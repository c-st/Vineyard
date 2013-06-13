#import "VYWineTableViewController.h"

@implementation VYWineTableViewController

- (void) viewDidLoad {
	[[self navigationItem] setRightBarButtonItems:@[
													[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addWineButtonPressed)],
													//[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addWineButtonPressed)]
													]];
}

- (void) addWineButtonPressed {
	NSLog(@"addWineButtonPressed");
}

@end
