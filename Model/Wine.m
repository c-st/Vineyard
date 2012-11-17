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
	return YES;
}

@end
