
#import "WineDetailViewController.h"
#import "AddWineViewController.h"

#import "UIColor+CellarColours.h"

@interface WineDetailViewController ()

@end

@implementation WineDetailViewController

@synthesize wine;

- (id) initWithWine:(Wine *)theWine {
	if ((self = [super init])) {
		[self setWine:theWine];
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	[self loadView];
}

- (void) loadView {
	[super loadView];
	[self setTitle:[NSString stringWithFormat:@"%@", wine.name]];
	[self.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
	[nameLabel setText:[NSString stringWithFormat:@"%@", wine.name]];
	[self.view addSubview:nameLabel];
	
	UIBarButtonItem *editButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Edit" style:UIBarButtonItemStylePlain target:self action: @selector(editWine)];
	[[self navigationItem] setRightBarButtonItem:editButton];
}

- (void) editWine {
	NSLog(@"edit");
	// Transition to AddWineViewController withWine
	AddWineViewController *wineViewController = [[AddWineViewController alloc] initWithWine:wine];
	
	[UIView animateWithDuration:0.5 animations:^{
		[[self navigationController] pushViewController:wineViewController animated:NO];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
		
	} completion:^(BOOL finished){}];
	
	/*
	[UIView  beginAnimations:@"switch" context:nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	[[self navigationController] pushViewController:wineViewController animated:NO];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[UIView commitAnimations];
	*/
	//[[self navigationController] pushViewController:wineViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
