// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemperatureRange.m instead.

#import "_TemperatureRange.h"

const struct TemperatureRangeAttributes TemperatureRangeAttributes = {
	.temperatureFrom = @"temperatureFrom",
	.temperatureTo = @"temperatureTo",
};

const struct TemperatureRangeRelationships TemperatureRangeRelationships = {
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"temperatureFromValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperatureFrom"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"temperatureToValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperatureTo"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic temperatureFrom;



- (double)temperatureFromValue {
	NSNumber *result = [self temperatureFrom];
	return [result doubleValue];
}

- (void)setTemperatureFromValue:(double)value_ {
	[self setTemperatureFrom:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTemperatureFromValue {
	NSNumber *result = [self primitiveTemperatureFrom];
	return [result doubleValue];
}

- (void)setPrimitiveTemperatureFromValue:(double)value_ {
	[self setPrimitiveTemperatureFrom:[NSNumber numberWithDouble:value_]];
}





@dynamic temperatureTo;



- (double)temperatureToValue {
	NSNumber *result = [self temperatureTo];
	return [result doubleValue];
}

- (void)setTemperatureToValue:(double)value_ {
	[self setTemperatureTo:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTemperatureToValue {
	NSNumber *result = [self primitiveTemperatureTo];
	return [result doubleValue];
}

- (void)setPrimitiveTemperatureToValue:(double)value_ {
	[self setPrimitiveTemperatureTo:[NSNumber numberWithDouble:value_]];
}





@dynamic wine;

	






@end
