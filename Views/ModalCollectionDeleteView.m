#import "ModalCollectionDeleteView.h"
#import "Collection.h"

@implementation ModalCollectionDeleteView

/*
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame andWine:nil];
	return self;
}
*/

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		NSLog(@"%i collections.", [[[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil] fetchedObjects] count]);
		[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
		
		// UI
        [self setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
		
		SSLineView *line = [[SSLineView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 2)];
		[line setLineColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.8]];
		[line setInsetColor:[UIColor whiteColor]];
		[self addSubview:line];
		
		// title
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 160, 20)];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor darkGrayColor]];
		[titleLabel setFont:[UIFont systemFontOfSize:17]];
		[titleLabel setText:@"Delete Collection"];
		[self addSubview:titleLabel];
		
		// right button
		self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[saveButton setFrame:CGRectMake(self.frame.size.width - 70, 10, 60, 30)];
		[saveButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[saveButton setTintColor:[UIColor lightGrayColor]];
		[saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		saveButton.layer.borderColor = [UIColor blackColor].CGColor;
		[saveButton setTitle:@"Done" forState:UIControlStateNormal];
		[saveButton addTarget:self.delegate action:@selector(triggerCancelButton) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:saveButton];
		
		// table view
		super.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 49, 280, 240)];
		[super.tableView setEditing:YES animated:YES];
		[super.tableView setDelegate:self];
		[super.tableView setDataSource:self];
		[super.tableView setBackgroundView:nil];
		[super.tableView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:super.tableView];
		
    }
    return self;
}

- (void) triggerCancelButton {
	[delegate cancelButtonPressed:nil];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	[collection deleteEntity];
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	
//	[super.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[super updateAndRefetch];
}
@end
