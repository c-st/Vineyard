// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.h instead.

#import <CoreData/CoreData.h>
#import "Location.h"

extern const struct CountryAttributes {
	__unsafe_unretained NSString *countryID;
	__unsafe_unretained NSString *isoCode;
	__unsafe_unretained NSString *name;
} CountryAttributes;

extern const struct CountryRelationships {
	__unsafe_unretained NSString *regions;
} CountryRelationships;

extern const struct CountryFetchedProperties {
} CountryFetchedProperties;

@class Region;





@interface CountryID : NSManagedObjectID {}
@end

@interface _Country : Location {}
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





@property (nonatomic, strong) NSSet* regions;

- (NSMutableSet*)regionsSet;





@end

@interface _Country (CoreDataGeneratedAccessors)

- (void)addRegions:(NSSet*)value_;
- (void)removeRegions:(NSSet*)value_;
- (void)addRegionsObject:(Region*)value_;
- (void)removeRegionsObject:(Region*)value_;

@end

@interface _Country (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCountryID;
- (void)setPrimitiveCountryID:(NSString*)value;




- (NSString*)primitiveIsoCode;
- (void)setPrimitiveIsoCode:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveRegions;
- (void)setPrimitiveRegions:(NSMutableSet*)value;


@end
