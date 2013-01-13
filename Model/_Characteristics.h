// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Characteristics.h instead.

#import <CoreData/CoreData.h>


extern const struct CharacteristicsAttributes {
	__unsafe_unretained NSString *acidity;
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *fruit;
	__unsafe_unretained NSString *sweetness;
	__unsafe_unretained NSString *tannin;
} CharacteristicsAttributes;

extern const struct CharacteristicsRelationships {
	__unsafe_unretained NSString *wine;
} CharacteristicsRelationships;

extern const struct CharacteristicsFetchedProperties {
} CharacteristicsFetchedProperties;

@class Wine;







@interface CharacteristicsID : NSManagedObjectID {}
@end

@interface _Characteristics : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CharacteristicsID*)objectID;





@property (nonatomic, strong) NSNumber* acidity;



@property int16_t acidityValue;
- (int16_t)acidityValue;
- (void)setAcidityValue:(int16_t)value_;

//- (BOOL)validateAcidity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* body;



@property int16_t bodyValue;
- (int16_t)bodyValue;
- (void)setBodyValue:(int16_t)value_;

//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* fruit;



@property int16_t fruitValue;
- (int16_t)fruitValue;
- (void)setFruitValue:(int16_t)value_;

//- (BOOL)validateFruit:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* sweetness;



@property int16_t sweetnessValue;
- (int16_t)sweetnessValue;
- (void)setSweetnessValue:(int16_t)value_;

//- (BOOL)validateSweetness:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* tannin;



@property int16_t tanninValue;
- (int16_t)tanninValue;
- (void)setTanninValue:(int16_t)value_;

//- (BOOL)validateTannin:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Wine *wine;

//- (BOOL)validateWine:(id*)value_ error:(NSError**)error_;





@end

@interface _Characteristics (CoreDataGeneratedAccessors)

@end

@interface _Characteristics (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAcidity;
- (void)setPrimitiveAcidity:(NSNumber*)value;

- (int16_t)primitiveAcidityValue;
- (void)setPrimitiveAcidityValue:(int16_t)value_;




- (NSNumber*)primitiveBody;
- (void)setPrimitiveBody:(NSNumber*)value;

- (int16_t)primitiveBodyValue;
- (void)setPrimitiveBodyValue:(int16_t)value_;




- (NSNumber*)primitiveFruit;
- (void)setPrimitiveFruit:(NSNumber*)value;

- (int16_t)primitiveFruitValue;
- (void)setPrimitiveFruitValue:(int16_t)value_;




- (NSNumber*)primitiveSweetness;
- (void)setPrimitiveSweetness:(NSNumber*)value;

- (int16_t)primitiveSweetnessValue;
- (void)setPrimitiveSweetnessValue:(int16_t)value_;




- (NSNumber*)primitiveTannin;
- (void)setPrimitiveTannin:(NSNumber*)value;

- (int16_t)primitiveTanninValue;
- (void)setPrimitiveTanninValue:(int16_t)value_;





- (Wine*)primitiveWine;
- (void)setPrimitiveWine:(Wine*)value;


@end
