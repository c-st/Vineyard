
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
	//[self setTitle:[NSString stringWithFormat:@"%@", wine.name]];
	[self setTitle:@"Wine"];
	//[self.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	UIBarButtonItem *editButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Edit" style:UIBarButtonItemStylePlain target:self action: @selector(editWine)];
	[[self navigationItem] setRightBarButtonItem:editButton];
	
	// Scroll view
	// Scroll view
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bound.origin.x,
																			  bound.origin.y,
																			  bound.size.width,
																			  bound.size.height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, 700)];//self.view.frame.size.height)];
	[scrollView setContentOffset: CGPointMake(0, 0)];
	[scrollView setContentInset:UIEdgeInsetsMake(21.0,0,0,0.0)];
	[scrollView setBackgroundColor:[UIColor cellarBeigeColour]];
	[scrollView setShowsVerticalScrollIndicator:NO];
	[scrollView setScrollEnabled:YES];
	[scrollView setUserInteractionEnabled:YES];
	[scrollView setDelegate:self];
	
	
	// White
	UILabel *whiteArea = [[UILabel alloc] initWithFrame:CGRectMake(bound.origin.x, bound.origin.y, bound.size.width, 200)];
	[whiteArea setBackgroundColor:[UIColor whiteColor]];
	whiteArea.shadowColor = [UIColor blackColor];
	whiteArea.shadowOffset = CGSizeMake(1.0, 1.0);
	[scrollView addSubview:whiteArea];
	
	// Name
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 25)];
	[nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
	[nameLabel setTextColor:[UIColor blackColor]];
	[nameLabel setText:[wine name]];

	[scrollView addSubview:nameLabel];
	
	[self.view addSubview:scrollView];
}

- (void) editWine {
	// Transition to AddWineViewController withWine
	AddWineViewController *addWineController = [[AddWineViewController alloc] initWithWine:wine];
	[UIView animateWithDuration:0.5 animations:^{
		[[self navigationController] pushViewController:addWineController animated:YES];
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
