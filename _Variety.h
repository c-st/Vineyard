// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Variety.h instead.

#import <CoreData/CoreData.h>


extern const struct VarietyAttributes {
} VarietyAttributes;

extern const struct VarietyRelationships {
	__unsafe_unretained NSString *wines;
} VarietyRelationships;

extern const struct VarietyFetchedProperties {
} VarietyFetchedProperties;

@class Wine;


@interface VarietyID : NSManagedObjectID {}
@end

@interface _Variety : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VarietyID*)objectID;





@property (nonatomic, strong) NSSet* wines;

- (NSMutableSet*)winesSet;





@end

@interface _Variety (CoreDataGeneratedAccessors)

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Variety (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
