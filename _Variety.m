// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Variety.m instead.

#import "_Variety.h"

const struct VarietyAttributes VarietyAttributes = {
};

const struct VarietyRelationships VarietyRelationships = {
	.wines = @"wines",
};

const struct VarietyFetchedProperties VarietyFetchedProperties = {
};

@implementation VarietyID
@end

@implementation _Variety

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

- (VarietyID*)objectID {
	return (VarietyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
