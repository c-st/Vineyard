#import "AddWineTableViewController.h"

@interface AddWineTableViewController ()

@end

@implementation AddWineTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
		CGRect bound = [[UIScreen mainScreen] bounds];
		float outerSpacing = 10.0f;
        [self.view setFrame:CGRectMake(bound.origin.x+outerSpacing, bound.origin.y, bound.size.width-2*outerSpacing, 400)];
		self.tableView.backgroundView = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"view did load");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
