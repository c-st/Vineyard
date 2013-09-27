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

#import "InitialDataImportService.h"

#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Setup MagicalRecord
    [MagicalRecord setupCoreDataStack];
	
	[Crashlytics startWithAPIKey:@"c37d25484429789917901b68f8c6c123a6b540e5"];
	
	//[InitialDataImportService clearStore];
	
	// import sample data
	/**
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		[InitialDataImportService importInitialDataFromJson:localContext];
	} completion:^(BOOL success, NSError *error) {
		NSLog(@"finished importing.");
	}];
	*/
	
	return YES;
    
    //[InitialDataImportService clearStore];
	
	// Build tab view controllers
	// Wines (Paperfold)
	
	//[wineTVC.view setTintColor:[UIColor cellarWineRedColour]];
	
	// Wine
	/*
	VYWineTableViewController *wineTVC = [[VYWineTableViewController alloc] init];
	[wineTVC setTitle:@"Wines"];
	UINavigationController *wineNavController = [[UINavigationController alloc] initWithRootViewController:wineTVC];
	[wineNavController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Wines" image:[UIImage imageNamed:@"food_wine_bottle_glass.png"] tag:0]];
	
	// Browse
	VYWineTableViewController *browseTVC = [[VYWineTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[browseTVC setTitle:@"Browse"];
	UINavigationController *browseNavController = [[UINavigationController alloc] initWithRootViewController:browseTVC];
	[browseNavController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Browse" image:[UIImage imageNamed:@"browse.png"] tag:0]];
	
	
	// Collections
	VYWineTableViewController *collectionsTVC = [[VYWineTableViewController alloc] init];
	[collectionsTVC setTitle:@"Collections"];
	UINavigationController *collectionsNavController = [[UINavigationController alloc] initWithRootViewController:collectionsTVC];
	[collectionsNavController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"box.png"] tag:0]];
	*/
	
	
	// ?
	/*
	// Browse (Paperfold)
	BrowseTableViewController *browseTVC = [[BrowseTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[browseTVC setTitle:@"Browse"];
	[browseTVC setShowCount:NO];
	[browseTVC setShowPieChart:NO];
	PaperFoldNavigationController *browsePaperFoldNC = [self createPaperFoldNavControllerForRootViewController:browseTVC
																								 andTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Browse" image:[UIImage imageNamed:@"browse.png"] tag:0]];
	
	// Collections
	// NSFetchedResultsController *collectionsFRC = [Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CollectionTableViewController *collectionsTVC = [[CollectionTableViewController alloc] initWithFetchedResultsController:nil];
	[collectionsTVC setTitle:@"Collections"];
	[collectionsTVC setShowCount:YES];
	[collectionsTVC setShowPieChart:NO];
	PaperFoldNavigationController *collectionPaperFoldNC = [self createPaperFoldNavControllerForRootViewController:collectionsTVC
																									 andTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Collections" image:[UIImage imageNamed:@"box.png"] tag:0]];
	
	// Countries // Food
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	[countryTVC setTitle:@"Food"];
	[countryTVC setShowCount:YES];
	[countryTVC setShowPieChart:YES];
	countryTVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"plate.png"] tag:0];
    UINavigationController *countryNavController = [[UINavigationController alloc] initWithRootViewController:countryTVC];
	

	*/
	/*
	UITabBarController *tab = [[UITabBarController alloc] init];
	[tab.view setTintColor:[UIColor cellarWineRedColour]];
	[tab setViewControllers:@[wineNavController, browseNavController, collectionsNavController]];
	
	
	[self.window setTintColor:[UIColor cellarWineRedColour]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[self.window setBackgroundColor:[UIColor blackColor]];
    [self.window addSubview:tab.view];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
	*/
	
	// initial data import
	/*
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tab.view animated:YES];
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.labelText = @"Importing some data...";
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		// Import sample data
		[InitialDataImportService importInitialDataFromJson:localContext];
	} completion:^(BOOL success, NSError *error) {
		[MBProgressHUD hideHUDForView:tab.view animated:YES];
	}];
	 */
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
    
    [MagicalRecord cleanUp];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Cellar" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Cellar.sqlite"];
    
	// handle db upgrade
	NSDictionary *options = @{@YES : NSMigratePersistentStoresAutomaticallyOption, @YES : NSInferMappingModelAutomaticallyOption};
	
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
