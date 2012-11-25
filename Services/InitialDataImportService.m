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

@implementation InitialDataImportService

+ (void)importInitialDataFromJson {
    // Import sample data
    NSError *error = nil;
    NSData *json = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil]];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&error];
   
    //NSLog(@"%@", data);
    id object;
	
	// Country
	if (![Country hasAtLeastOneEntity]) {
		NSLog(@"Importing countries...");
		for (object in [data objectForKey:@"countries"]) {
			//NSLog(@"inserting new country: %@", object);
			Country *newCountry = [Country createEntity];
			[newCountry importValuesForKeysWithObject:object];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
	
	//Classification
	if (![Classification hasAtLeastOneEntity]) {
		NSLog(@"Importing classifications...");
		for (object in [data objectForKey:@"classifications"]) {
			//NSLog(@"inserting new region: %@", object);
			Classification *newClassification = [Classification createEntity];
			[newClassification importValuesForKeysWithObject:object];
        
			[newClassification setCountry:[[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"]] objectAtIndex:0]];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
	
	//Indication
	if (![Indication hasAtLeastOneEntity]) {
		NSLog(@"Importing indications...");
		for (object in [data objectForKey:@"indications"]) {
			//NSLog(@"inserting new region: %@", object);
			Indication *newIndication = [Indication createEntity];
			[newIndication importValuesForKeysWithObject:object];
        
			[newIndication setCountry:[[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"]] objectAtIndex:0]];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
    
    // Region
	if (![Region hasAtLeastOneEntity]) {
		NSLog(@"Importing regions...");
		for (object in [data objectForKey:@"regions"]) {
			//NSLog(@"inserting new region: %@", object);
			Region *newRegion = [Region createEntity];
			[newRegion importValuesForKeysWithObject:object];
        
			[newRegion setCountry:[[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"]] objectAtIndex:0]];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
	
	// Appellation
	if (![Appellation hasAtLeastOneEntity]) {
		NSLog(@"Importing appellations...");
		for (object in [data objectForKey:@"appellations"]) {
			//NSLog(@"inserting new appellation: %@", object);
			Appellation *newAppellation = [Appellation createEntity];
			[newAppellation importValuesForKeysWithObject:object];
			[newAppellation setRegion:[[Region findByAttribute:@"regionID" withValue:[object valueForKeyPath:@"regionID"]] objectAtIndex:0]];
		
			if (![[object valueForKeyPath:@"classificationID"] isEqualToString:@""]) {
				[newAppellation setClassification:[[Classification findByAttribute:@"classificationID" withValue:[object valueForKeyPath:@"classificationID"]] objectAtIndex:0]];
			}
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
	
	// Grape Type
	if (![GrapeType hasAtLeastOneEntity]) {
		NSLog(@"Importing grape types...");
		for (object in [data objectForKey:@"grapeTypes"]) {
			//NSLog(@"inserting new varietal: %@", object);
			GrapeType *newGrapeType = [GrapeType createEntity];
			[newGrapeType importValuesForKeysWithObject:object];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
	}
	
	// Varietals
	if (![Varietal hasAtLeastOneEntity]) {
		NSLog(@"Importing varietals...");
		for (object in [data objectForKey:@"varietals"]) {
			//NSLog(@"inserting new varietal: %@", object);
			Varietal *newVarietal = [Varietal createEntity];
			[newVarietal importValuesForKeysWithObject:object];
			
			[newVarietal setGrapeType:[[GrapeType findByAttribute:@"grapeTypeID" withValue:[object valueForKeyPath:@"grapeTypeID"]] objectAtIndex:0]];
		}
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
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
