
#import "BrowseTableViewController.h"

@interface BrowseTableViewController ()

@end

@implementation BrowseTableViewController

- (id) init {
	if ((self = [super init])) {
		// init
	}
    return self;
}

- (void) viewWillAppear:(BOOL) animated {
	//[super viewWillAppear:animated];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	[self.tableView setBackgroundView:nil];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	cell.textLabel.text = @"Hellow";
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BrowseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setSelectionStyle:UITableViewCellEditingStyleNone];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	/*
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	*/
	
	//[self.navigationController popViewControllerAnimated:YES];
}

@end
