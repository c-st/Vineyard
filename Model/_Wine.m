// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Wine.m instead.

#import "_Wine.h"

const struct WineAttributes WineAttributes = {
	.alcoholContent = @"alcoholContent",
	.creationTime = @"creationTime",
	.image = @"image",
	.imageThumbnail = @"imageThumbnail",
	.name = @"name",
	.price = @"price",
	.rating = @"rating",
	.vintage = @"vintage",
};

const struct WineRelationships WineRelationships = {
	.appellation = @"appellation",
	.characteristics = @"characteristics",
	.collections = @"collections",
	.colour = @"colour",
	.country = @"country",
	.location = @"location",
	.servingTemperature = @"servingTemperature",
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

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"alcoholContentValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"alcoholContent"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"vintageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"vintage"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic alcoholContent;



- (double)alcoholContentValue {
	NSNumber *result = [self alcoholContent];
	return [result doubleValue];
}

- (void)setAlcoholContentValue:(double)value_ {
	[self setAlcoholContent:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveAlcoholContentValue {
	NSNumber *result = [self primitiveAlcoholContent];
	return [result doubleValue];
}

- (void)setPrimitiveAlcoholContentValue:(double)value_ {
	[self setPrimitiveAlcoholContent:[NSNumber numberWithDouble:value_]];
}





@dynamic creationTime;






@dynamic image;






@dynamic imageThumbnail;






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





@dynamic vintage;



- (int16_t)vintageValue {
	NSNumber *result = [self vintage];
	return [result shortValue];
}

- (void)setVintageValue:(int16_t)value_ {
	[self setVintage:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveVintageValue {
	NSNumber *result = [self primitiveVintage];
	return [result shortValue];
}

- (void)setPrimitiveVintageValue:(int16_t)value_ {
	[self setPrimitiveVintage:[NSNumber numberWithShort:value_]];
}





@dynamic appellation;

	

@dynamic characteristics;

	

@dynamic collections;

	
- (NSMutableSet*)collectionsSet {
	[self willAccessValueForKey:@"collections"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"collections"];
  
	[self didAccessValueForKey:@"collections"];
	return result;
}
	

@dynamic colour;

	

@dynamic country;

	

@dynamic location;

	

@dynamic servingTemperature;

	

@dynamic varietals;

	
- (NSMutableSet*)varietalsSet {
	[self willAccessValueForKey:@"varietals"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"varietals"];
  
	[self didAccessValueForKey:@"varietals"];
	return result;
}
	

@dynamic winery;

	






@end
