// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemperatureRange.m instead.

#import "_TemperatureRange.h"

const struct TemperatureRangeAttributes TemperatureRangeAttributes = {
	.temperatureFrom = @"temperatureFrom",
	.temperatureTo = @"temperatureTo",
};

const struct TemperatureRangeRelationships TemperatureRangeRelationships = {
	.grape = @"grape",
	.wine = @"wine",
};

const struct TemperatureRangeFetchedProperties TemperatureRangeFetchedProperties = {
};

@implementation TemperatureRangeID
@end

@implementation _TemperatureRange

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TemperatureRange" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TemperatureRange";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TemperatureRange" inManagedObjectContext:moc_];
}

- (TemperatureRangeID*)objectID {
	return (TemperatureRangeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"temperatureFromValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperatureFrom"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"temperatureToValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperatureTo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic temperatureFrom;



- (float)temperatureFromValue {
	NSNumber *result = [self temperatureFrom];
	return [result floatValue];
}

- (void)setTemperatureFromValue:(float)value_ {
	[self setTemperatureFrom:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTemperatureFromValue {
	NSNumber *result = [self primitiveTemperatureFrom];
	return [result floatValue];
}

- (void)setPrimitiveTemperatureFromValue:(float)value_ {
	[self setPrimitiveTemperatureFrom:[NSNumber numberWithFloat:value_]];
}





@dynamic temperatureTo;



- (float)temperatureToValue {
	NSNumber *result = [self temperatureTo];
	return [result floatValue];
}

- (void)setTemperatureToValue:(float)value_ {
	[self setTemperatureTo:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTemperatureToValue {
	NSNumber *result = [self primitiveTemperatureTo];
	return [result floatValue];
}

- (void)setPrimitiveTemperatureToValue:(float)value_ {
	[self setPrimitiveTemperatureTo:[NSNumber numberWithFloat:value_]];
}





@dynamic grape;

	

@dynamic wine;

	






@end
