// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Indication.h instead.

#import <CoreData/CoreData.h>


extern const struct IndicationAttributes {
	__unsafe_unretained NSString *indicationID;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *qualityRating;
	__unsafe_unretained NSString *type;
} IndicationAttributes;

extern const struct IndicationRelationships {
	__unsafe_unretained NSString *country;
} IndicationRelationships;

extern const struct IndicationFetchedProperties {
} IndicationFetchedProperties;

@class Country;






@interface IndicationID : NSManagedObjectID {}
@end

@interface _Indication : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IndicationID*)objectID;




@property (nonatomic, strong) NSString* indicationID;


//- (BOOL)validateIndicationID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* qualityRating;


@property int16_t qualityRatingValue;
- (int16_t)qualityRatingValue;
- (void)setQualityRatingValue:(int16_t)value_;

//- (BOOL)validateQualityRating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Country* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@end

@interface _Indication (CoreDataGeneratedAccessors)

@end

@interface _Indication (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveIndicationID;
- (void)setPrimitiveIndicationID:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveQualityRating;
- (void)setPrimitiveQualityRating:(NSNumber*)value;

- (int16_t)primitiveQualityRatingValue;
- (void)setPrimitiveQualityRatingValue:(int16_t)value_;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (Country*)primitiveCountry;
- (void)setPrimitiveCountry:(Country*)value;


@end
