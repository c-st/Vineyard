#import <UIKit/UIKit.h>
#import "Wine.h"
#import "AbstractTableViewController.h"

typedef NS_ENUM( NSUInteger, SettingsCellType ) {
	TextSettingsCellType,
	DetailViewSettingsCellType
};

@interface SettingsCell : UITableViewCell <UITextFieldDelegate> {
	SettingsCellType *cellType;
	Wine *wine;
	NSString *propertyIdentifier;
	NSString *name;
	
	// optional property (only for DetailViewSettingsCellType).
	AbstractTableViewController *settingsViewController;
}

//methods
- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName;

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andViewController:(AbstractTableViewController*)theViewController;

- (void) updatePredicateAndRefetch;

- (void) valueWasSelected:(NSManagedObject*)managedObject;

@property (nonatomic) SettingsCellType *cellType;

@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) NSString *propertyIdentifier;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) AbstractTableViewController *settingsViewController;

@end
