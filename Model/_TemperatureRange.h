// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemperatureRange.h instead.

#import <CoreData/CoreData.h>


extern const struct TemperatureRangeAttributes {
	__unsafe_unretained NSString *temperatureFrom;
	__unsafe_unretained NSString *temperatureTo;
} TemperatureRangeAttributes;

extern const struct TemperatureRangeRelationships {
	__unsafe_unretained NSString *wine;
} TemperatureRangeRelationships;

extern const struct TemperatureRangeFetchedProperties {
} TemperatureRangeFetchedProperties;

@class Wine;




@interface TemperatureRangeID : NSManagedObjectID {}
@end

@interface _TemperatureRange : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TemperatureRangeID*)objectID;




@property (nonatomic, strong) NSNumber* temperatureFrom;


@property double temperatureFromValue;
- (double)temperatureFromValue;
- (void)setTemperatureFromValue:(double)value_;

//- (BOOL)validateTemperatureFrom:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* temperatureTo;


@property double temperatureToValue;
- (double)temperatureToValue;
- (void)setTemperatureToValue:(double)value_;

//- (BOOL)validateTemperatureTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Wine* wine;

//- (BOOL)validateWine:(id*)value_ error:(NSError**)error_;





@end

@interface _TemperatureRange (CoreDataGeneratedAccessors)

@end

@interface _TemperatureRange (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveTemperatureFrom;
- (void)setPrimitiveTemperatureFrom:(NSNumber*)value;

- (double)primitiveTemperatureFromValue;
- (void)setPrimitiveTemperatureFromValue:(double)value_;




- (NSNumber*)primitiveTemperatureTo;
- (void)setPrimitiveTemperatureTo:(NSNumber*)value;

- (double)primitiveTemperatureToValue;
- (void)setPrimitiveTemperatureToValue:(double)value_;





- (Wine*)primitiveWine;
- (void)setPrimitiveWine:(Wine*)value;


@end
