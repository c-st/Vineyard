#import "RightWineFoldViewController.h"

#import "UIColor+CellarColours.h"
#import <QuartzCore/QuartzCore.h>

@interface RightWineFoldViewController ()

@end

@implementation RightWineFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor darkGrayColor]];
	
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(-10, 0, 13, self.view.frame.size.height);
	shadow.endPoint = CGPointMake(1.0, 0.5);
	shadow.startPoint = CGPointMake(0, 0.5);
	shadow.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
	[self.view.layer addSublayer:shadow];
}

- (void) layoutSubviews {

}

- (void) viewWillAppear:(BOOL)animated {
	NSLog(@"viewWillAppear");
}

@end
