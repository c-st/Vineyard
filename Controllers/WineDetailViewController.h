#import <UIKit/UIKit.h>
#import "Wine.h"

@interface WineDetailViewController : UIViewController <UIScrollViewDelegate> {
	Wine *wine;
}

@property (nonatomic, strong) Wine *wine;

- (id) initWithWine:(Wine *) theWine;

@end
