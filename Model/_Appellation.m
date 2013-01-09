// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appellation.m instead.

#import "_Appellation.h"

const struct AppellationAttributes AppellationAttributes = {
	.appellationID = @"appellationID",
	.name = @"name",
};

const struct AppellationRelationships AppellationRelationships = {
	.classification = @"classification",
	.region = @"region",
	.wines = @"wines",
};

const struct AppellationFetchedProperties AppellationFetchedProperties = {
};

@implementation AppellationID
@end

@implementation _Appellation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Appellation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Appellation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Appellation" inManagedObjectContext:moc_];
}

- (AppellationID*)objectID {
	return (AppellationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic appellationID;






@dynamic name;






@dynamic classification;

	

@dynamic region;

	

@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
