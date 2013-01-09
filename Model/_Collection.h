// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Collection.h instead.

#import <CoreData/CoreData.h>


extern const struct CollectionAttributes {
	__unsafe_unretained NSString *name;
} CollectionAttributes;

extern const struct CollectionRelationships {
	__unsafe_unretained NSString *wines;
} CollectionRelationships;

extern const struct CollectionFetchedProperties {
} CollectionFetchedProperties;

@class Wine;



@interface CollectionID : NSManagedObjectID {}
@end

@interface _Collection : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CollectionID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *wines;

- (NSMutableSet*)winesSet;





@end

@interface _Collection (CoreDataGeneratedAccessors)

- (void)addWines:(NSSet*)value_;
- (void)removeWines:(NSSet*)value_;
- (void)addWinesObject:(Wine*)value_;
- (void)removeWinesObject:(Wine*)value_;

@end

@interface _Collection (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveWines;
- (void)setPrimitiveWines:(NSMutableSet*)value;


@end
