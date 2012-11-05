// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Region.m instead.

#import "_Region.h"

const struct RegionAttributes RegionAttributes = {
	.name = @"name",
	.regionID = @"regionID",
};

const struct RegionRelationships RegionRelationships = {
	.appellations = @"appellations",
	.country = @"country",
	.wineries = @"wineries",
};

const struct RegionFetchedProperties RegionFetchedProperties = {
};

@implementation RegionID
@end

@implementation _Region

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Region" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Region";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Region" inManagedObjectContext:moc_];
}

- (RegionID*)objectID {
	return (RegionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic regionID;






@dynamic appellations;

	

@dynamic country;

	

@dynamic wineries;

	
- (NSMutableSet*)wineriesSet {
	[self willAccessValueForKey:@"wineries"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wineries"];
  
	[self didAccessValueForKey:@"wineries"];
	return result;
}
	






@end
