// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodAttributes {
} FoodAttributes;

extern const struct FoodRelationships {
	__unsafe_unretained NSString *varietal;
} FoodRelationships;

extern const struct FoodFetchedProperties {
} FoodFetchedProperties;

@class Varietal;


@interface FoodID : NSManagedObjectID {}
@end

@interface _Food : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodID*)objectID;





@property (nonatomic, strong) Varietal *varietal;

//- (BOOL)validateVarietal:(id*)value_ error:(NSError**)error_;





@end

@interface _Food (CoreDataGeneratedAccessors)

@end

@interface _Food (CoreDataGeneratedPrimitiveAccessors)



- (Varietal*)primitiveVarietal;
- (void)setPrimitiveVarietal:(Varietal*)value;


@end
