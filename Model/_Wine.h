// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Wine.h instead.

#import <CoreData/CoreData.h>


extern const struct WineAttributes {
	__unsafe_unretained NSString *creationTime;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *vintage;
} WineAttributes;

extern const struct WineRelationships {
	__unsafe_unretained NSString *appellation;
	__unsafe_unretained NSString *colour;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *varietals;
	__unsafe_unretained NSString *winery;
} WineRelationships;

extern const struct WineFetchedProperties {
} WineFetchedProperties;

@class Appellation;
@class GrapeType;
@class Country;
@class Varietal;
@class Winery;








@interface WineID : NSManagedObjectID {}
@end

@interface _Wine : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (WineID*)objectID;




@property (nonatomic, strong) NSDate* creationTime;


//- (BOOL)validateCreationTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSData* image;


//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* price;


@property double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* rating;


@property int16_t ratingValue;
- (int16_t)ratingValue;
- (void)setRatingValue:(int16_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* vintage;


//- (BOOL)validateVintage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Appellation* appellation;

//- (BOOL)validateAppellation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) GrapeType* colour;

//- (BOOL)validateColour:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Country* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* varietals;

- (NSMutableSet*)varietalsSet;




@property (nonatomic, strong) Winery* winery;

//- (BOOL)validateWinery:(id*)value_ error:(NSError**)error_;





@end

@interface _Wine (CoreDataGeneratedAccessors)

- (void)addVarietals:(NSSet*)value_;
- (void)removeVarietals:(NSSet*)value_;
- (void)addVarietalsObject:(Varietal*)value_;
- (void)removeVarietalsObject:(Varietal*)value_;

@end

@interface _Wine (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreationTime;
- (void)setPrimitiveCreationTime:(NSDate*)value;




- (NSData*)primitiveImage;
- (void)setPrimitiveImage:(NSData*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int16_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int16_t)value_;




- (NSString*)primitiveVintage;
- (void)setPrimitiveVintage:(NSString*)value;





- (Appellation*)primitiveAppellation;
- (void)setPrimitiveAppellation:(Appellation*)value;



- (GrapeType*)primitiveColour;
- (void)setPrimitiveColour:(GrapeType*)value;



- (Country*)primitiveCountry;
- (void)setPrimitiveCountry:(Country*)value;



- (NSMutableSet*)primitiveVarietals;
- (void)setPrimitiveVarietals:(NSMutableSet*)value;



- (Winery*)primitiveWinery;
- (void)setPrimitiveWinery:(Winery*)value;


@end
