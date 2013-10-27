#import "Wine.h"

#import "Appellation.h"
#import "Region.h"
@implementation Wine

- (BOOL) isValid {
	if (self.appellation != nil && self.country != nil) {
		// appellation.region.country != country
		if (self.appellation.region.country != self.country) {
			return NO;
		}
	}
	
	if (self.name.length == 0) {
		return NO;
	}
	
	if ([self.varietals count] > 0) {
		// validate that all varietals are from the same colour.
	}
	
	return YES;
}


- (void) extendWine {
	if (self.appellation != nil) {
		// create relationship to country, region
		[self setCountry:self.appellation.region.country];
	}
	
	if ([self.varietals count] > 0) {
		
	}
}

// Creates a sorted string expression of all varietals of this wine
- (NSString *) varietalsString {
	NSString *varietalsString = [[NSString alloc] init];
	if ([self.varietals count] > 0) {
		NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
		NSArray *sortedVarietals = [[self.varietalsSet allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
		for (id v in sortedVarietals) {
			NSLog(@"%@", [v name]);
			varietalsString = [varietalsString stringByAppendingFormat:@"%@ ", [v name]];
		
		}
	}
	return varietalsString;
}

@end
