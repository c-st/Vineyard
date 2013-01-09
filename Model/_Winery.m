// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Winery.m instead.

#import "_Winery.h"

const struct WineryAttributes WineryAttributes = {
	.name = @"name",
};

const struct WineryRelationships WineryRelationships = {
	.region = @"region",
	.wines = @"wines",
};

const struct WineryFetchedProperties WineryFetchedProperties = {
};

@implementation WineryID
@end

@implementation _Winery

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Winery" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Winery";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Winery" inManagedObjectContext:moc_];
}

- (WineryID*)objectID {
	return (WineryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic region;

	

@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
