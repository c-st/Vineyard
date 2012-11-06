// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Classification.m instead.

#import "_Classification.h"

const struct ClassificationAttributes ClassificationAttributes = {
	.name = @"name",
};

const struct ClassificationRelationships ClassificationRelationships = {
	.appellations = @"appellations",
	.country = @"country",
};

const struct ClassificationFetchedProperties ClassificationFetchedProperties = {
};

@implementation ClassificationID
@end

@implementation _Classification

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Classification" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Classification";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Classification" inManagedObjectContext:moc_];
}

- (ClassificationID*)objectID {
	return (ClassificationID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic appellations;

	

@dynamic country;

	






@end
