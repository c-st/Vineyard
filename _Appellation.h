// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appellation.h instead.

#import <CoreData/CoreData.h>


extern const struct AppellationAttributes {
	__unsafe_unretained NSString *name;
} AppellationAttributes;

extern const struct AppellationRelationships {
	__unsafe_unretained NSString *region;
	__unsafe_unretained NSString *wines;
} AppellationRelationships;

extern const struct AppellationFetchedProperties {
} AppellationFetchedProperties;

@class Region;
@class Wine;



@interface AppellationID : NSManagedObjectID {}
@end

@interface _Appellation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AppellationID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Region* region;

//- (BOOL)validateRegion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* wines;

- (NSMutableSet*)winesSet;





@end

@interface _Appellation (CoreDataGeneratedAccessors)

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Appellation (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (Region*)primitiveRegion;
- (void)setPrimitiveRegion:(Region*)value;



- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
