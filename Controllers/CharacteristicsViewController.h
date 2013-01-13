#import <UIKit/UIKit.h>
#import "SettingsCell.h"
#import "SliderPageControl.h"
#import "Characteristics.h"

@interface CharacteristicsViewController : UIViewController <SliderPageControlDelegate> {
	SettingsCell *settingsCell;
	Characteristics *characteristics;
	
	NSMutableDictionary *values;
}

@property (nonatomic, strong) SettingsCell* settingsCell;
@property (nonatomic, strong) Characteristics* characteristics;

@property (nonatomic, strong) NSMutableDictionary* values;

@end
