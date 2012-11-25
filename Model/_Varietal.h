// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Varietal.h instead.

#import <CoreData/CoreData.h>


extern const struct VarietalAttributes {
	__unsafe_unretained NSString *colour;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *varietalID;
} VarietalAttributes;

extern const struct VarietalRelationships {
	__unsafe_unretained NSString *wines;
} VarietalRelationships;

extern const struct VarietalFetchedProperties {
} VarietalFetchedProperties;

@class Wine;





@interface VarietalID : NSManagedObjectID {}
@end

@interface _Varietal : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VarietalID*)objectID;




@property (nonatomic, strong) NSString* colour;


//- (BOOL)validateColour:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* varietalID;


//- (BOOL)validateVarietalID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* wines;

- (NSMutableSet*)winesSet;





@end

@interface _Varietal (CoreDataGeneratedAccessors)

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Varietal (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveColour;
- (void)setPrimitiveColour:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveVarietalID;
- (void)setPrimitiveVarietalID:(NSString*)value;





- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
