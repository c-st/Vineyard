#import "WineFilterFoldViewController.h"

#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"

#import <QuartzCore/QuartzCore.h>

#import "CountryTableViewController.h"
#import "PopoverView.h"

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
	
	UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[locationButton addTarget:self action:@selector(displayLocationPopOver:) forControlEvents:UIControlEventTouchUpInside];
	[locationButton setFrame:CGRectMake(38, 50, 38, 38)];
	[locationButton setImage:[[UIImage imageNamed:@"globe.png"] imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
	[self.view addSubview:locationButton];

}

- (void) displayLocationPopOver:(UIButton *) sender {
	CGPoint centerPoint = CGPointMake(sender.frame.origin.x + (sender.frame.size.width / 2), sender.frame.origin.y + (sender.frame.size.height / 2));
	
	//[PopoverView showPopoverAtPoint:centerPoint inView:self.view withTitle:@"Location Location Location" withStringArray:[NSArray arrayWithObjects:@"YES", @"NO", nil] delegate:self];
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *cTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    tableView.delegate = self;
    tableView.dataSource = self;
	
	[PopoverView showPopoverAtPoint:centerPoint inView:self.view withContentView:tableView delegate:self];
}

- (void) layoutSubviews {

}

- (void) viewWillAppear:(BOOL)animated {
	NSLog(@"viewWillAppear");
}

- (void) viewDidAppear:(BOOL)animated {
	//[PopoverView showPopoverAtPoint:CGPointMake(10, 10) inView:self.view withTitle:@"Was this helpful?" withStringArray:[NSArray arrayWithObjects:@"YES", @"NO", nil] delegate:self];
	
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"text";
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    return cell;
}

@end
