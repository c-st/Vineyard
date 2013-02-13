#import "KLNoteViewController.h"
#import "ModalTextFieldView.h"

@interface NoteRootViewController : UIViewController <KLNoteViewControllerDataSource, KLNoteViewControllerDelegate, ModalViewDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic, strong) KLNoteViewController* noteViewController;
@end
