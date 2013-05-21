#import "ModalView.h"
#import "Wine.h"

@interface ModalCollectionView : ModalView<UITableViewDataSource, UITableViewDelegate> {
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableArray *assignedCollections;

@property (nonatomic, strong) Wine *wine;

- (id)initWithFrame:(CGRect)frame andWine:(Wine *) theWine;

- (void) updateAndRefetch;

@end
