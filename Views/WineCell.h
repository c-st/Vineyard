#import <UIKit/UIKit.h>
#import "Wine.h"

@interface WineCell : UITableViewCell {
	Wine *wine;
	UIView *cellBackgroundView;
}

@property (retain, nonatomic) UIView* cellBackgroundView;
@property (nonatomic, strong) Wine *wine;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine;

@end
