// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.h instead.

#import <CoreData/CoreData.h>


extern const struct CountryAttributes {
	__unsafe_unretained NSString *countryID;
	__unsafe_unretained NSString *isoCode;
	__unsafe_unretained NSString *name;
} CountryAttributes;

extern const struct CountryRelationships {
	__unsafe_unretained NSString *classifications;
	__unsafe_unretained NSString *indications;
	__unsafe_unretained NSString *regions;
	__unsafe_unretained NSString *wines;
} CountryRelationships;

extern const struct CountryFetchedProperties {
} CountryFetchedProperties;

@class Classification;
@class Indication;
@class Region;
@class Wine;





@interface CountryID : NSManagedObjectID {}
@end

@interface _Country : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CountryID*)objectID;





@property (nonatomic, strong) NSString* countryID;



//- (BOOL)validateCountryID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* isoCode;



//- (BOOL)validateIsoCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *classifications;

- (NSMutableSet*)classificationsSet;




@property (nonatomic, strong) NSSet *indications;

- (NSMutableSet*)indicationsSet;




@property (nonatomic, strong) NSSet *regions;

- (NSMutableSet*)regionsSet;




@property (nonatomic, strong) NSSet *wines;

- (NSMutableSet*)winesSet;





@end

@interface _Country (CoreDataGeneratedAccessors)

- (void)addClassifications:(NSSet*)value_;
- (void)removeClassifications:(NSSet*)value_;
- (void)addClassificationsObject:(Classification*)value_;
- (void)removeClassificationsObject:(Classification*)value_;

- (void)addIndications:(NSSet*)value_;
- (void)removeIndications:(NSSet*)value_;
- (void)addIndicationsObject:(Indication*)value_;
- (void)removeIndicationsObject:(Indication*)value_;

- (void)addRegions:(NSSet*)value_;
- (void)removeRegions:(NSSet*)value_;
- (void)addRegionsObject:(Region*)value_;
- (void)removeRegionsObject:(Region*)value_;

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Country (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCountryID;
- (void)setPrimitiveCountryID:(NSString*)value;




- (NSString*)primitiveIsoCode;
- (void)setPrimitiveIsoCode:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveClassifications;
- (void)setPrimitiveClassifications:(NSMutableSet*)value;



- (NSMutableSet*)primitiveIndications;
- (void)setPrimitiveIndications:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRegions;
- (void)setPrimitiveRegions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
