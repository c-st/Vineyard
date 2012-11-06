// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Winery.h instead.

#import <CoreData/CoreData.h>


extern const struct WineryAttributes {
} WineryAttributes;

extern const struct WineryRelationships {
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *wines;
} WineryRelationships;

extern const struct WineryFetchedProperties {
} WineryFetchedProperties;

@class Region;
@class Wine;


@interface WineryID : NSManagedObjectID {}
@end

@interface _Winery : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (WineryID*)objectID;





@property (nonatomic, strong) Region* region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wines;

- (NSMutableSet*)winesSet;





@end

@interface _Winery (CoreDataGeneratedAccessors)

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Winery (CoreDataGeneratedPrimitiveAccessors)



- (Region*)primitiveRegion;
- (void)setPrimitiveRegion:(Region*)value;



- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
