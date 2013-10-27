#import "_Wine.h"

@interface Wine : _Wine {}
- (BOOL) isValid;

/*
 Extend information (set country, when only region was set etc.).
 */
- (void) extendWine;
- (NSString *) varietalsString;

@end
