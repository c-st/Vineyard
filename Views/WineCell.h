#import <UIKit/UIKit.h>
#import "Wine.h"

@interface WineCell : UITableViewCell {
	Wine *wine;
	UIView *cellBackgroundView;
	UIView *toolbarView;
}

@property (retain, nonatomic) UIView* cellBackgroundView;
@property (retain, nonatomic) UIView* toolbarView;
@property (nonatomic, strong) Wine *wine;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine;

- (void) displayToolArea:(BOOL)isDisplay;
@end
