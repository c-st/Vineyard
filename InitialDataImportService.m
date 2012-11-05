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
#import "Region.h"

@implementation InitialDataImportService

+ (void)importInitialDataFromJson {
    // Import sample data
    NSError *error = nil;
    NSData *json = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil]];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&error];

    
    NSLog(@"%@", data);
    id object;
    for (object in [data objectForKey:@"countries"]) {
        NSLog(@"inserting new country: %@", object);
        Country *newCountry = [Country createEntity];
        [newCountry importValuesForKeysWithObject:object];
    }
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    
    
    for (object in [data objectForKey:@"regions"]) {
        NSLog(@"inserting new region: %@", object);
        Region *newRegion = [Region createEntity];
        [newRegion importValuesForKeysWithObject:object];
        
        [newRegion setCountry:[[Country findByAttribute:@"countryID" withValue:[object valueForKeyPath:@"countryID"]] objectAtIndex:0]];
    }
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    
    
    
}

@end
