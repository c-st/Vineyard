// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Varietal.m instead.

#import "_Varietal.h"

const struct VarietalAttributes VarietalAttributes = {
	.name = @"name",
	.varietalID = @"varietalID",
};

const struct VarietalRelationships VarietalRelationships = {
	.grapeType = @"grapeType",
	.matchingFood = @"matchingFood",
	.wines = @"wines",
};

const struct VarietalFetchedProperties VarietalFetchedProperties = {
};

@implementation VarietalID
@end

@implementation _Varietal

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Varietal" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Varietal";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Varietal" inManagedObjectContext:moc_];
}

- (VarietalID*)objectID {
	return (VarietalID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic varietalID;






@dynamic grapeType;

	

@dynamic matchingFood;

	

@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
