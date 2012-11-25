// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GrapeType.m instead.

#import "_GrapeType.h"

const struct GrapeTypeAttributes GrapeTypeAttributes = {
	.grapeTypeID = @"grapeTypeID",
	.name = @"name",
};

const struct GrapeTypeRelationships GrapeTypeRelationships = {
	.varietals = @"varietals",
};

const struct GrapeTypeFetchedProperties GrapeTypeFetchedProperties = {
};

@implementation GrapeTypeID
@end

@implementation _GrapeType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GrapeType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GrapeType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GrapeType" inManagedObjectContext:moc_];
}

- (GrapeTypeID*)objectID {
	return (GrapeTypeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic grapeTypeID;






@dynamic name;






@dynamic varietals;

	
- (NSMutableSet*)varietalsSet {
	[self willAccessValueForKey:@"varietals"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"varietals"];
  
	[self didAccessValueForKey:@"varietals"];
	return result;
}
	






@end
