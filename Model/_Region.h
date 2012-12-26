// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Region.h instead.

#import <CoreData/CoreData.h>


extern const struct RegionAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *regionID;
} RegionAttributes;

extern const struct RegionRelationships {
	__unsafe_unretained NSString *appellations;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *wineries;
} RegionRelationships;

extern const struct RegionFetchedProperties {
} RegionFetchedProperties;

@class Appellation;
@class Country;
@class Location;
@class Winery;




@interface RegionID : NSManagedObjectID {}
@end

@interface _Region : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RegionID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* regionID;


//- (BOOL)validateRegionID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* appellations;

- (NSMutableSet*)appellationsSet;




@property (nonatomic, strong) Country* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Location* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wineries;

- (NSMutableSet*)wineriesSet;





@end

@interface _Region (CoreDataGeneratedAccessors)

- (void)addAppellations:(NSSet*)value_;
- (void)removeAppellations:(NSSet*)value_;
- (void)addAppellationsObject:(Appellation*)value_;
- (void)removeAppellationsObject:(Appellation*)value_;

- (void)addWineries:(NSSet*)value_;
- (void)removeWineries:(NSSet*)value_;
- (void)addWineriesObject:(Winery*)value_;
- (void)removeWineriesObject:(Winery*)value_;

@end

@interface _Region (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveRegionID;
- (void)setPrimitiveRegionID:(NSString*)value;





- (NSMutableSet*)primitiveAppellations;
- (void)setPrimitiveAppellations:(NSMutableSet*)value;



- (Country*)primitiveCountry;
- (void)setPrimitiveCountry:(Country*)value;



- (Location*)primitiveLocation;
- (void)setPrimitiveLocation:(Location*)value;



- (NSMutableSet*)primitiveWineries;
- (void)setPrimitiveWineries:(NSMutableSet*)value;


@end
