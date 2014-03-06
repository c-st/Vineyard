//
//  VYTakePhotoViewController.h
//  Vineyard
//
//  Created by Christian Stangier on 05.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VYAddEditWineViewController.h"
#import "UIImage+Resize.h"

@interface VYTakePhotoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	BOOL _alreadyPresented;
}

@property (weak, nonatomic) UIImage *wineImage;

@end
