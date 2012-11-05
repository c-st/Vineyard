// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Classification.h instead.

#import <CoreData/CoreData.h>


extern const struct ClassificationAttributes {
} ClassificationAttributes;

extern const struct ClassificationRelationships {
	__unsafe_unretained NSString *appellations;
} ClassificationRelationships;

extern const struct ClassificationFetchedProperties {
} ClassificationFetchedProperties;

@class Appellation;


@interface ClassificationID : NSManagedObjectID {}
@end

@interface _Classification : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ClassificationID*)objectID;





@property (nonatomic, strong) Appellation* appellations;

//- (BOOL)validateAppellations:(id*)value_ error:(NSError**)error_;





@end

@interface _Classification (CoreDataGeneratedAccessors)

@end

@interface _Classification (CoreDataGeneratedPrimitiveAccessors)



- (Appellation*)primitiveAppellations;
- (void)setPrimitiveAppellations:(Appellation*)value;


@end
