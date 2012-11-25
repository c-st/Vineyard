// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Varietal.m instead.

#import "_Varietal.h"

const struct VarietalAttributes VarietalAttributes = {
	.colour = @"colour",
	.name = @"name",
	.varietalID = @"varietalID",
};

const struct VarietalRelationships VarietalRelationships = {
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic colour;






@dynamic name;






@dynamic varietalID;






@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
