// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TemperatureRange.h instead.

#import <CoreData/CoreData.h>


extern const struct TemperatureRangeAttributes {
	__unsafe_unretained NSString *temperatureFrom;
	__unsafe_unretained NSString *temperatureTo;
} TemperatureRangeAttributes;

extern const struct TemperatureRangeRelationships {
	__unsafe_unretained NSString *grape;
	__unsafe_unretained NSString *wine;
} TemperatureRangeRelationships;

extern const struct TemperatureRangeFetchedProperties {
} TemperatureRangeFetchedProperties;

@class GrapeType;
@class Wine;




@interface TemperatureRangeID : NSManagedObjectID {}
@end

@interface _TemperatureRange : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TemperatureRangeID*)objectID;




@property (nonatomic, strong) NSNumber* temperatureFrom;


@property float temperatureFromValue;
- (float)temperatureFromValue;
- (void)setTemperatureFromValue:(float)value_;

//- (BOOL)validateTemperatureFrom:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* temperatureTo;


@property float temperatureToValue;
- (float)temperatureToValue;
- (void)setTemperatureToValue:(float)value_;

//- (BOOL)validateTemperatureTo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) GrapeType* grape;

//- (BOOL)validateGrape:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Wine* wine;

//- (BOOL)validateWine:(id*)value_ error:(NSError**)error_;





@end

@interface _TemperatureRange (CoreDataGeneratedAccessors)

@end

@interface _TemperatureRange (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveTemperatureFrom;
- (void)setPrimitiveTemperatureFrom:(NSNumber*)value;

- (float)primitiveTemperatureFromValue;
- (void)setPrimitiveTemperatureFromValue:(float)value_;




- (NSNumber*)primitiveTemperatureTo;
- (void)setPrimitiveTemperatureTo:(NSNumber*)value;

- (float)primitiveTemperatureToValue;
- (void)setPrimitiveTemperatureToValue:(float)value_;





- (GrapeType*)primitiveGrape;
- (void)setPrimitiveGrape:(GrapeType*)value;



- (Wine*)primitiveWine;
- (void)setPrimitiveWine:(Wine*)value;


@end
