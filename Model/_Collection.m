// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Collection.m instead.

#import "_Collection.h"

const struct CollectionAttributes CollectionAttributes = {
	.name = @"name",
};

const struct CollectionRelationships CollectionRelationships = {
	.wines = @"wines",
};

const struct CollectionFetchedProperties CollectionFetchedProperties = {
};

@implementation CollectionID
@end

@implementation _Collection

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Collection";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Collection" inManagedObjectContext:moc_];
}

- (CollectionID*)objectID {
	return (CollectionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic wines;

	
- (NSMutableSet*)winesSet {
	[self willAccessValueForKey:@"wines"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wines"];
  
	[self didAccessValueForKey:@"wines"];
	return result;
}
	






@end
