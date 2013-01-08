#import <UIKit/UIKit.h>
#import "SettingsCell.h"
#import "SliderPageControl.h"

@interface CharacteristicsViewController : UIViewController <SliderPageControlDelegate> {
	SettingsCell *settingsCell;
}

@property (nonatomic, strong) SettingsCell* settingsCell;

@end
