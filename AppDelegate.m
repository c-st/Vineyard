#import "UIColor+CellarColours.h"

#import "AppDelegate.h"

#import "VYWineTableViewController.h"


#import "MagicalRecord.h"

#import "Appellation.h"
#import "Country.h"
#import "Classification.h"
#import "Indication.h"
#import "Region.h"
#import "Wine.h"
#import "Varietal.h"
#import "GrapeType.h"

#import "UIColor+VineyardColours.h"

#import "InitialDataImportService.h"

#import <Crashlytics/Crashlytics.h>

static NSString * const kVineyardStoreName = @"Vineyard.sqlite";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Setup MagicalRecord
    [MagicalRecord setupCoreDataStackWithStoreNamed:kVineyardStoreName];
	
	[Crashlytics startWithAPIKey:@"c37d25484429789917901b68f8c6c123a6b540e5"];
	
	//[InitialDataImportService clearStore];
	
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		[InitialDataImportService importInitialDataFromJson:localContext];
	} completion:^(BOOL success, NSError *error) {
		NSLog(@"finished importing.");
	}];
    
    // workaround for non-working tint colour
    [self.window setTintColor:[UIColor vineyardRed]];
	
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}


@end
