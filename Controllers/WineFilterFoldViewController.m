#import "WineFilterFoldViewController.h"

#import "UIColor+CellarColours.h"
#import <QuartzCore/QuartzCore.h>

@interface WineFilterFoldViewController ()

@end

@implementation WineFilterFoldViewController

- (void) viewDidLoad {
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor darkGrayColor]]; //darkGray
	
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(115, 0, 5, self.view.frame.size.height);
	shadow.startPoint = CGPointMake(1.0, 0.5);
	shadow.endPoint = CGPointMake(0, 0.5);
	shadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.6] CGColor], (id)[[UIColor clearColor] CGColor], nil];
	[self.view.layer addSublayer:shadow];
	
	UILabel *filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 7, 90, 30)];
	[filterLabel setBackgroundColor:[UIColor clearColor]];
	[filterLabel setTextAlignment:NSTextAlignmentCenter];
	[filterLabel setTextColor:[UIColor whiteColor]];
	filterLabel.shadowColor = [UIColor blackColor];
	filterLabel.shadowOffset = CGSizeMake(0.0, -1.0);
	[filterLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:20]];
	[filterLabel setText:@"Filter"];
	[self.view addSubview:filterLabel];
}

- (void) layoutSubviews {

}

- (void) viewWillAppear:(BOOL)animated {
	NSLog(@"viewWillAppear");
}

@end
