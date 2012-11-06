// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Classification.h instead.

#import <CoreData/CoreData.h>


extern const struct ClassificationAttributes {
	__unsafe_unretained NSString *name;
} ClassificationAttributes;

extern const struct ClassificationRelationships {
	__unsafe_unretained NSString *appellations;
	__unsafe_unretained NSString *country;
} ClassificationRelationships;

extern const struct ClassificationFetchedProperties {
} ClassificationFetchedProperties;

@class Appellation;
@class Country;



@interface ClassificationID : NSManagedObjectID {}
@end

@interface _Classification : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ClassificationID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Appellation* appellations;

//- (BOOL)validateAppellations:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Country* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@end

@interface _Classification (CoreDataGeneratedAccessors)

@end

@interface _Classification (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (Appellation*)primitiveAppellations;
- (void)setPrimitiveAppellations:(Appellation*)value;



- (Country*)primitiveCountry;
- (void)setPrimitiveCountry:(Country*)value;


@end
