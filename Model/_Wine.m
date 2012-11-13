// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Wine.m instead.

#import "_Wine.h"

const struct WineAttributes WineAttributes = {
	.creationTime = @"creationTime",
	.image = @"image",
	.name = @"name",
	.price = @"price",
	.rating = @"rating",
};

const struct WineRelationships WineRelationships = {
	.appellation = @"appellation",
	.country = @"country",
	.varietals = @"varietals",
	.winery = @"winery",
};

const struct WineFetchedProperties WineFetchedProperties = {
};

@implementation WineID
@end

@implementation _Wine

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Wine" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Wine";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Wine" inManagedObjectContext:moc_];
}

- (WineID*)objectID {
	return (WineID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic creationTime;






@dynamic image;






@dynamic name;






@dynamic price;



- (double)priceValue {
	NSNumber *result = [self price];
	return [result doubleValue];
}

- (void)setPriceValue:(double)value_ {
	[self setPrice:[NSNumber numberWithDouble:value_]];
}

- (double)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result doubleValue];
}

- (void)setPrimitivePriceValue:(double)value_ {
	[self setPrimitivePrice:[NSNumber numberWithDouble:value_]];
}





@dynamic rating;



- (int16_t)ratingValue {
	NSNumber *result = [self rating];
	return [result shortValue];
}

- (void)setRatingValue:(int16_t)value_ {
	[self setRating:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result shortValue];
}

- (void)setPrimitiveRatingValue:(int16_t)value_ {
	[self setPrimitiveRating:[NSNumber numberWithShort:value_]];
}





@dynamic appellation;

	

@dynamic country;

	

@dynamic varietals;

	
- (NSMutableSet*)varietalsSet {
	[self willAccessValueForKey:@"varietals"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"varietals"];
  
	[self didAccessValueForKey:@"varietals"];
	return result;
}
	

@dynamic winery;

	






@end
