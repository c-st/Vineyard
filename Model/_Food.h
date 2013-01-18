// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodAttributes {
	__unsafe_unretained NSString *foodId;
	__unsafe_unretained NSString *name;
} FoodAttributes;

extern const struct FoodRelationships {
	__unsafe_unretained NSString *varietals;
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





@property (nonatomic, strong) NSString* foodId;



//- (BOOL)validateFoodId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *varietals;

- (NSMutableSet*)varietalsSet;





@end

@interface _Food (CoreDataGeneratedAccessors)

- (void)addVarietals:(NSSet*)value_;
- (void)removeVarietals:(NSSet*)value_;
- (void)addVarietalsObject:(Varietal*)value_;
- (void)removeVarietalsObject:(Varietal*)value_;

@end

@interface _Food (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFoodId;
- (void)setPrimitiveFoodId:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveVarietals;
- (void)setPrimitiveVarietals:(NSMutableSet*)value;


@end
