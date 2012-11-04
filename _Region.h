// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Region.h instead.

#import <CoreData/CoreData.h>
#import "Location.h"

extern const struct RegionAttributes {
} RegionAttributes;

extern const struct RegionRelationships {
	__unsafe_unretained NSString *appellations;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *wineries;
} RegionRelationships;

extern const struct RegionFetchedProperties {
} RegionFetchedProperties;

@class Appellation;
@class Country;
@class Winery;


@interface RegionID : NSManagedObjectID {}
@end

@interface _Region : Location {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RegionID*)objectID;





@property (nonatomic, strong) Appellation* appellations;

//- (BOOL)validateAppellations:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Country* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wineries;

- (NSMutableSet*)wineriesSet;





@end

@interface _Region (CoreDataGeneratedAccessors)

- (void)addWineries:(NSSet*)value_;
- (void)removeWineries:(NSSet*)value_;
- (void)addWineriesObject:(Winery*)value_;
- (void)removeWineriesObject:(Winery*)value_;

@end

@interface _Region (CoreDataGeneratedPrimitiveAccessors)



- (Appellation*)primitiveAppellations;
- (void)setPrimitiveAppellations:(Appellation*)value;



- (Country*)primitiveCountry;
- (void)setPrimitiveCountry:(Country*)value;



- (NSMutableSet*)primitiveWineries;
- (void)setPrimitiveWineries:(NSMutableSet*)value;


@end
