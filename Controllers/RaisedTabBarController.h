//
//  RaisedTabBarController.h
//  Cellar
//
//  Created by Christian Stangier on 07.11.12.
//  Copyright (c) 2012 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaisedTabBarController : UITabBarController

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*)title image:(UIImage*)image;

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end
