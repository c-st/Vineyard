// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Classification.m instead.

#import "_Classification.h"

const struct ClassificationAttributes ClassificationAttributes = {
	.classificationID = @"classificationID",
	.name = @"name",
	.qualityRating = @"qualityRating",
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

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"qualityRatingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"qualityRating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic classificationID;






@dynamic name;






@dynamic qualityRating;



- (int16_t)qualityRatingValue {
	NSNumber *result = [self qualityRating];
	return [result shortValue];
}

- (void)setQualityRatingValue:(int16_t)value_ {
	[self setQualityRating:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveQualityRatingValue {
	NSNumber *result = [self primitiveQualityRating];
	return [result shortValue];
}

- (void)setPrimitiveQualityRatingValue:(int16_t)value_ {
	[self setPrimitiveQualityRating:[NSNumber numberWithShort:value_]];
}





@dynamic appellations;

	

@dynamic country;

	






@end
