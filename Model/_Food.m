// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.m instead.

#import "_Food.h"

const struct FoodAttributes FoodAttributes = {
	.foodId = @"foodId",
	.name = @"name",
};

const struct FoodRelationships FoodRelationships = {
	.varietals = @"varietals",
};

const struct FoodFetchedProperties FoodFetchedProperties = {
};

@implementation FoodID
@end

@implementation _Food

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Food";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Food" inManagedObjectContext:moc_];
}

- (FoodID*)objectID {
	return (FoodID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic foodId;






@dynamic name;






@dynamic varietals;

	
- (NSMutableSet*)varietalsSet {
	[self willAccessValueForKey:@"varietals"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"varietals"];
  
	[self didAccessValueForKey:@"varietals"];
	return result;
}
	






@end
