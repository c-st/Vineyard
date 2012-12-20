//  UIImage+Scale.h

#import "UIImage+Scale.h"

@implementation UIImage (scale)

-(UIImage*)scaleToSize:(CGSize)size
{
	// Create a bitmap graphics context
	// This will also set it as the current context
	
//	UIGraphicsBeginImageContext(size);
//	UIGraphicsBeginImageContextWithOptions(size, NO, 2.0f);
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	} else {
		UIGraphicsBeginImageContext(size);
	}
	
	
	//CGContextRef context = UIGraphicsGetCurrentContext();
	//CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
	
	// Draw the scaled image in the current context
	[self drawInRect:CGRectMake(0, 0, size.width, size.height)];
	
	// Create a new image from current context
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Pop the current context from the stack
	UIGraphicsEndImageContext();
	
	// Return our new scaled image
	return scaledImage;
}

@end