// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Characteristics.m instead.

#import "_Characteristics.h"

const struct CharacteristicsAttributes CharacteristicsAttributes = {
	.acidity = @"acidity",
	.body = @"body",
	.fruit = @"fruit",
	.sweetness = @"sweetness",
	.tannin = @"tannin",
};

const struct CharacteristicsRelationships CharacteristicsRelationships = {
	.wine = @"wine",
};

const struct CharacteristicsFetchedProperties CharacteristicsFetchedProperties = {
};

@implementation CharacteristicsID
@end

@implementation _Characteristics

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Characteristics" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Characteristics";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Characteristics" inManagedObjectContext:moc_];
}

- (CharacteristicsID*)objectID {
	return (CharacteristicsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"acidityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"acidity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"bodyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"body"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"fruitValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fruit"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"sweetnessValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sweetness"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tanninValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tannin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic acidity;



- (int16_t)acidityValue {
	NSNumber *result = [self acidity];
	return [result shortValue];
}

- (void)setAcidityValue:(int16_t)value_ {
	[self setAcidity:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAcidityValue {
	NSNumber *result = [self primitiveAcidity];
	return [result shortValue];
}

- (void)setPrimitiveAcidityValue:(int16_t)value_ {
	[self setPrimitiveAcidity:[NSNumber numberWithShort:value_]];
}





@dynamic body;



- (int16_t)bodyValue {
	NSNumber *result = [self body];
	return [result shortValue];
}

- (void)setBodyValue:(int16_t)value_ {
	[self setBody:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveBodyValue {
	NSNumber *result = [self primitiveBody];
	return [result shortValue];
}

- (void)setPrimitiveBodyValue:(int16_t)value_ {
	[self setPrimitiveBody:[NSNumber numberWithShort:value_]];
}





@dynamic fruit;



- (int16_t)fruitValue {
	NSNumber *result = [self fruit];
	return [result shortValue];
}

- (void)setFruitValue:(int16_t)value_ {
	[self setFruit:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveFruitValue {
	NSNumber *result = [self primitiveFruit];
	return [result shortValue];
}

- (void)setPrimitiveFruitValue:(int16_t)value_ {
	[self setPrimitiveFruit:[NSNumber numberWithShort:value_]];
}





@dynamic sweetness;



- (int16_t)sweetnessValue {
	NSNumber *result = [self sweetness];
	return [result shortValue];
}

- (void)setSweetnessValue:(int16_t)value_ {
	[self setSweetness:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSweetnessValue {
	NSNumber *result = [self primitiveSweetness];
	return [result shortValue];
}

- (void)setPrimitiveSweetnessValue:(int16_t)value_ {
	[self setPrimitiveSweetness:[NSNumber numberWithShort:value_]];
}





@dynamic tannin;



- (int16_t)tanninValue {
	NSNumber *result = [self tannin];
	return [result shortValue];
}

- (void)setTanninValue:(int16_t)value_ {
	[self setTannin:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTanninValue {
	NSNumber *result = [self primitiveTannin];
	return [result shortValue];
}

- (void)setPrimitiveTanninValue:(int16_t)value_ {
	[self setPrimitiveTannin:[NSNumber numberWithShort:value_]];
}





@dynamic wine;

	






@end
