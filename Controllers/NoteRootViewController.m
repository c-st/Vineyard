#import "NoteRootViewController.h"
#import "UIColor+CellarColours.h"
#import "WineTableViewController.h"

@interface NoteRootViewController ()

@end

@implementation NoteRootViewController

- (void) viewDidLoad {
    [super viewDidLoad];
	NSLog(@"viewDidLoad");
	[self.navigationController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	UIViewController *vc1 = [[UIViewController alloc] init];
	[vc1.navigationItem setTitle:@"First one"];
	[vc1.view setFrame:self.view.frame];
	[vc1.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];

	UIViewController *vc2 = [[UIViewController alloc] init];
	[vc2.navigationItem setTitle:@"Another one"];
	[vc2.view setFrame:self.view.frame];
	[vc2.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	
	UIViewController *vc3 = [[UIViewController alloc] init];
	[vc3.navigationItem setTitle:@"Lieblingsweine"];
	[vc3.view setFrame:self.view.frame];
	[vc3.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	
	self.controllers = @[vc1, vc2, vc3];
	
	
	
	self.noteViewController = [[KLNoteViewController alloc] init];
	[self.noteViewController setDataSource:self];
	[self.noteViewController setDelegate:self];
	[self.noteViewController reloadData];
	
	[self.view addSubview:self.noteViewController.view];
	[self.view setBackgroundColor:[UIColor blackColor]];
	
	
}

- (NSInteger)numberOfControllerCardsInNoteView:(KLNoteViewController*) noteView {
	return [self.controllers count];
}

- (UIViewController *)noteView:(KLNoteViewController*)noteView viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.controllers objectAtIndex:indexPath.row];
}

-(void) noteViewController: (KLNoteViewController*) noteViewController didUpdateControllerCard:(KLControllerCard*)controllerCard toDisplayState:(KLControllerCardState) toState fromDisplayState:(KLControllerCardState) fromState {
	
   // NSLog(@"changed state %ld", toState);
    
}


@end
