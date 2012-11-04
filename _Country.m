// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.m instead.

#import "_Country.h"

const struct CountryAttributes CountryAttributes = {
	.name = @"name",
};

const struct CountryRelationships CountryRelationships = {
	.regions = @"regions",
};

const struct CountryFetchedProperties CountryFetchedProperties = {
};

@implementation CountryID
@end

@implementation _Country

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Country";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Country" inManagedObjectContext:moc_];
}

- (CountryID*)objectID {
	return (CountryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic regions;

	
- (NSMutableSet*)regionsSet {
	[self willAccessValueForKey:@"regions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"regions"];
  
	[self didAccessValueForKey:@"regions"];
	return result;
}
	






@end
