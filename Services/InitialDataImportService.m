//
//  InitialDataImportController.m
//  Cellar
//
//  Created by Christian Stangier on 05.11.12.
//  Copyright (c) 2012 Christian Stangier. All rights reserved.
//

#import "InitialDataImportService.h"

#import "MagicalRecord.h"

#import "Appellation.h"
#import "Country.h"
#import "Classification.h"
#import "Region.h"
#import "Indication.h"
#import "Varietal.h"
#import "GrapeType.h"
#import "TemperatureRange.h"
#import "Location.h"

@implementation InitialDataImportService

+ (void)importInitialDataFromJson:(NSManagedObjectContext*) context {
    // Import sample data
    NSError *error = nil;
    NSData *json = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil]];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&error];
   
    //NSLog(@"%@", data);
    id object;
	
	// Country
	if (![Country hasAtLeastOneEntity]) {
		NSLog(@"Importing countries...");
		for (object in data[@"countries"]) {
			[Country importFromObject:object inContext:context];
			//NSLog(@"inserting new country: %@", object);
//			Country *newCountry = [Country createInContext:context];
//			[newCountry importValuesForKeysWithObject:object];
		}
	}

	//Classification
	if (![Classification hasAtLeastOneEntity]) {
		NSLog(@"Importing classifications...");
		for (object in data[@"classifications"]) {
			//NSLog(@"inserting new region: %@", object);
			Classification *newClassification = [Classification createInContext:context];
			[newClassification importValuesForKeysWithObject:object];
			[newClassification setCountry:[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"] inContext:context][0]];
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	//Indication
	if (![Indication hasAtLeastOneEntity]) {
		NSLog(@"Importing indications...");
		for (object in data[@"indications"]) {
			//NSLog(@"inserting new region: %@", object);
			Indication *newIndication = [Indication createInContext:context];
			[newIndication importValuesForKeysWithObject:object];
        
			[newIndication setCountry:[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"] inContext:context][0]];
		}
		//[context saveToPersistentStoreAndWait];
	}
 
    // Region
	if (![Region hasAtLeastOneEntity]) {
		NSLog(@"Importing regions...");
		for (object in data[@"regions"]) {
			//NSLog(@"inserting new region: %@", object);
			Region *newRegion = [Region createInContext:context];
			[newRegion importValuesForKeysWithObject:object];
        
			[newRegion setCountry:[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"] inContext:context][0]];
		}
		//[context saveToPersistentStoreAndWait];
	}

	// Appellation
	if (![Appellation hasAtLeastOneEntity]) {
		NSLog(@"Importing appellations...");
		for (object in data[@"appellations"]) {
			//NSLog(@"inserting new appellation: %@", object);
			Appellation *newAppellation = [Appellation createInContext:context];
			[newAppellation importValuesForKeysWithObject:object];
			[newAppellation setRegion:[Region findByAttribute:@"regionID" withValue:[object valueForKeyPath:@"regionID"] inContext:context][0]];
		
			if (![[object valueForKeyPath:@"classificationID"] isEqualToString:@""]) {
				[newAppellation setClassification:[Classification findByAttribute:@"classificationID" withValue:[object valueForKeyPath:@"classificationID"] inContext:context][0]];
			}
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	// Grape Type
	if (![GrapeType hasAtLeastOneEntity]) {
		NSLog(@"Importing grape types...");
		for (object in data[@"grapeTypes"]) {
			//NSLog(@"inserting new varietal: %@", object);
			GrapeType *newGrapeType = [GrapeType createInContext:context];
			[newGrapeType importValuesForKeysWithObject:object];
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	// Temperature ranges
	if (![TemperatureRange hasAtLeastOneEntity]) {
		NSLog(@"Importing temperature ranges...");
		for (object in data[@"defaultTemperatureRanges"]) {
			//NSLog(@"inserting new varietal: %@", object);
			TemperatureRange *newTemperatureRange = [TemperatureRange createInContext:context];
			[newTemperatureRange importValuesForKeysWithObject:object];
			
			[newTemperatureRange setGrape:[GrapeType findByAttribute:@"grapeTypeID" withValue:[object valueForKeyPath:@"grapeTypeID"] inContext:context][0]];
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	// Varietals
	if (![Varietal hasAtLeastOneEntity]) {
		NSLog(@"Importing varietals...");
		for (object in data[@"varietals"]) {
			//NSLog(@"inserting new varietal: %@", object);
			Varietal *newVarietal = [Varietal createInContext:context];
			[newVarietal importValuesForKeysWithObject:object];
			
			[newVarietal setGrapeType:[GrapeType findByAttribute:@"grapeTypeID" withValue:[object valueForKeyPath:@"grapeTypeID"] inContext:context][0]];
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	// Locations for Regions
	if (![Location hasAtLeastOneEntity]) {
		NSLog(@"Importing locations for regions...");
		for (object in data[@"regionLocations"]) {
			//NSLog(@"inserting new location for region: %@", object);
			Location *location = [Location createInContext:context];
			[location setLatitude:[object valueForKeyPath:@"latitude"]];
			[location setLongitude:[object valueForKeyPath:@"longitude"]];
			[location setRegion:[Region findByAttribute:@"regionID" withValue:[object valueForKeyPath:@"regionID"] inContext:context][0]];
			//NSLog(@"location: %@", location);
			
		}
		//[context saveToPersistentStoreAndWait];
	}
	
	NSLog(@"done importing!");
}

+ (void)clearStore {
    [MagicalRecord cleanUp];
    NSError *error = nil;
    NSURL *storeUrl = [NSPersistentStore urlForStoreName:[MagicalRecord defaultStoreName]];
    [[NSFileManager defaultManager] removeItemAtURL:storeUrl error:&error];
    NSLog(@"Default store was reset.");
    [MagicalRecord setupCoreDataStack];
}

@end
