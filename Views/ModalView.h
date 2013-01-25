#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "SSToolkit.h"

#import "UIColor+CellarColours.h"

@class ModalView;
@protocol ModalViewDelegate <NSObject>

@required
- (void) cancelButtonPressed:(id) textField;
- (void) saveButtonPressed:(id) textField;
@end

@interface ModalView : UIView {
	__weak id <ModalViewDelegate> delegate;
	UIButton *saveButton;
}

@property (nonatomic, weak) id <ModalViewDelegate> delegate;
@property (nonatomic, strong) UIButton *saveButton;

@end
