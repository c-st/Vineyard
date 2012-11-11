#import <UIKit/UIKit.h>
#import "Wine.h"

typedef NS_ENUM( NSUInteger, SettingsCellType ) {
	TextSettingsCellType,
	DetailViewSettingsCellType
};

@interface SettingsCell : UITableViewCell <UITextFieldDelegate> {
	SettingsCellType *cellType;
	
	Wine *wine;
	NSString *propertyIdentifier;
	NSString *name;
}

//methods
- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName;

- (void) selected;

@property (nonatomic) SettingsCellType *cellType;

@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) NSString *propertyIdentifier;
@property (nonatomic, strong) NSString *name;

@end
