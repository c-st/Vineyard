
#import "ModalCollectionView.h"

#import "Collection.h"

@implementation ModalCollectionView

@synthesize fetchedResultsController, assignedCollections, wine, tableView;

- (id)initWithFrame:(CGRect)frame andWine:(Wine *) theWine {
    self = [super initWithFrame:frame];
    if (self) {
		NSLog(@"%i collections.", [[[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil] fetchedObjects] count]);
		[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
		
		[self setWine:theWine];
		self.assignedCollections = [[NSMutableArray alloc] init];
		[self.assignedCollections addObjectsFromArray:[[[wine collections] allObjects] mutableCopy]];
		NSLog(@"%i", [wine.collections count]);
		
		// UI
        [self setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
		
		SSLineView *line = [[SSLineView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 2)];
		[line setLineColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.8]];
		[line setInsetColor:[UIColor whiteColor]];
		[self addSubview:line];
		
		// left button
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[cancelButton setFrame:CGRectMake(10, 10, 60, 30)];
		[cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[cancelButton setTintColor:[UIColor lightGrayColor]];
		[cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
		[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
		[cancelButton addTarget:self.delegate action:@selector(triggerCancelButton) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:cancelButton];
		
		// title
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 160, 20)];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor darkGrayColor]];
		[titleLabel setFont:[UIFont systemFontOfSize:17]];
		[titleLabel setText:@"Add To Collection"];
		[self addSubview:titleLabel];
		
		// right button
		self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[saveButton setFrame:CGRectMake(self.frame.size.width - 70, 10, 60, 30)];
		[saveButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[saveButton setTintColor:[UIColor lightGrayColor]];
		[saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		saveButton.layer.borderColor = [UIColor blackColor].CGColor;
		[saveButton setTitle:@"Done" forState:UIControlStateNormal];
		[saveButton addTarget:self.delegate action:@selector(triggerSaveButton) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:saveButton];

		// table view
		self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 49, 280, 200)];
		[tableView setDelegate:self];
		[tableView setDataSource:self];
		[tableView setBackgroundView:nil];
		[tableView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:tableView];
    }
    return self;
}

- (void) triggerCancelButton {
	[delegate cancelButtonPressed:nil];
}

- (void) triggerSaveButton {
	[delegate saveButtonPressed:self.assignedCollections];
}

#pragma mark - table view delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
    static NSString *CellIdentifier = @"CollectionModalCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell.textLabel setText:[collection name]];
		[cell.textLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
	
	if ([self.assignedCollections containsObject:collection]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		[cell setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	if ([self.assignedCollections containsObject:collection]) {
		[self.assignedCollections removeObject:collection];
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	} else {
		[self.assignedCollections addObject:collection];
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
