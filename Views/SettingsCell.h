#import <UIKit/UIKit.h>

#import "Country.h"
#import "GrapeType.h"
#import "Wine.h"
#import "TemperatureRange.h"

#import "AbstractTableViewController.h"
#import "SSToolkit.h"

typedef NS_ENUM( NSUInteger, SettingsCellType ) {
	TextSettingsCellType,
	NumberSettingsCellType,
	YearSettingsCellType,
	AlcoholSettingsCellType,
	RangeSettingsCellType,
	DetailViewSettingsCellType,
	RatingSettingsCellType,
	DeleteWineCellType
};

@interface SettingsCell : UITableViewCell <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
	SettingsCellType *cellType;
	Wine *wine;
	NSString *propertyIdentifier;
	NSString *name;
	
	UITextField *textField;
	
	// optional properties (only for DetailViewSettingsCellType).
	AbstractTableViewController *settingsTableViewController;
	UIViewController *viewController;
}

//methods
- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName;

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andTableViewController:(AbstractTableViewController*)theViewController;

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andViewController:(UIViewController*)theViewController;

- (void) updatePredicateAndRefetch;

// Value was selected in ViewController
- (void) valueWasSelected:(NSManagedObject*)managedObject;
- (void) listValueWasSelected:(NSSet*)list;
- (void) objectValueWasSelected:(id)object;

@property (nonatomic) SettingsCellType *cellType;

@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) NSString *propertyIdentifier;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) AbstractTableViewController *settingsTableViewController;
@property (nonatomic, strong) UIViewController *viewController;

@end
