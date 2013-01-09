// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GrapeType.h instead.

#import <CoreData/CoreData.h>


extern const struct GrapeTypeAttributes {
	__unsafe_unretained NSString *grapeTypeID;
	__unsafe_unretained NSString *name;
} GrapeTypeAttributes;

extern const struct GrapeTypeRelationships {
	__unsafe_unretained NSString *defaultTemperatureRange;
	__unsafe_unretained NSString *varietals;
	__unsafe_unretained NSString *wines;
} GrapeTypeRelationships;

extern const struct GrapeTypeFetchedProperties {
} GrapeTypeFetchedProperties;

@class TemperatureRange;
@class Varietal;
@class Wine;




@interface GrapeTypeID : NSManagedObjectID {}
@end

@interface _GrapeType : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GrapeTypeID*)objectID;





@property (nonatomic, strong) NSString* grapeTypeID;



//- (BOOL)validateGrapeTypeID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) TemperatureRange *defaultTemperatureRange;

//- (BOOL)validateDefaultTemperatureRange:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *varietals;

- (NSMutableSet*)varietalsSet;




@property (nonatomic, strong) NSSet *wines;

- (NSMutableSet*)winesSet;





@end

@interface _GrapeType (CoreDataGeneratedAccessors)

- (void)addVarietals:(NSSet*)value_;
- (void)removeVarietals:(NSSet*)value_;
- (void)addVarietalsObject:(Varietal*)value_;
- (void)removeVarietalsObject:(Varietal*)value_;

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _GrapeType (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveGrapeTypeID;
- (void)setPrimitiveGrapeTypeID:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (TemperatureRange*)primitiveDefaultTemperatureRange;
- (void)setPrimitiveDefaultTemperatureRange:(TemperatureRange*)value;



- (NSMutableSet*)primitiveVarietals;
- (void)setPrimitiveVarietals:(NSMutableSet*)value;



- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
