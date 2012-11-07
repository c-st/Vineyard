// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Indication.m instead.

#import "_Indication.h"

const struct IndicationAttributes IndicationAttributes = {
	.indicationID = @"indicationID",
	.name = @"name",
	.qualityRating = @"qualityRating",
	.type = @"type",
};

const struct IndicationRelationships IndicationRelationships = {
	.country = @"country",
};

const struct IndicationFetchedProperties IndicationFetchedProperties = {
};

@implementation IndicationID
@end

@implementation _Indication

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Indication" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Indication";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Indication" inManagedObjectContext:moc_];
}

- (IndicationID*)objectID {
	return (IndicationID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"qualityRatingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"qualityRating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic indicationID;






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





@dynamic type;






@dynamic country;

	






@end
