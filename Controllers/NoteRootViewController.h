#import "KLNoteViewController.h"

@interface NoteRootViewController : UIViewController <KLNoteViewControllerDataSource, KLNoteViewControllerDelegate>

@property(nonatomic, strong) KLNoteViewController* noteViewController;
@property(nonatomic, strong) NSArray* controllers;
@end
