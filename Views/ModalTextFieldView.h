
#import <UIKit/UIKit.h>
#import "UIColor+CellarColours.h"

#import "SSToolkit.h"
#import <QuartzCore/QuartzCore.h>

@class ModalTextFieldView;
@protocol ModalTextFieldViewDelegate <NSObject>

@required
- (void) cancelButtonPressed:(UITextField*) textField;
- (void) saveButtonPressed:(UITextField*) textField;
@end

@interface ModalTextFieldView : UIView {
	__weak id <ModalTextFieldViewDelegate> delegate;
	UIButton *saveButton;
	UITextField* textField;
}

@property (nonatomic, weak) id <ModalTextFieldViewDelegate> delegate;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *saveButton;

@end
