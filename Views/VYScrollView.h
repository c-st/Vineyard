//
//  VYScrollView.h
//  Vineyard
//
//  Created by Christian Stangier on 01.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VYScrollView;

@protocol VYScrollViewDelegate
-(UIView*) accessoryViewForScrollView:(VYScrollView*)scrollView;

@optional
-(void) headerLoadedInScrollView:(VYScrollView*)scrollView;
-(void) headerUnloadedInScrollView:(VYScrollView*)scrollView;

-(void) footerLoadedInScrollView:(VYScrollView*)scrollView;
-(void) footerUnloadedInScrollView:(VYScrollView*)scrollView;

@end

@interface VYScrollView : UIScrollView<UIScrollViewDelegate> {
	id<VYScrollViewDelegate, UIScrollViewDelegate> externalDelegate;
	
	IBOutlet UIView* headerView;
	IBOutlet UIView* footerView;
	
	BOOL _headerLoaded;
	BOOL _footerLoaded;
	BOOL _accessoryViewActive;
}

@property (nonatomic) IBOutlet UIView* headerView;
@property (nonatomic) IBOutlet UIView* footerView;

@property (nonatomic) UIView* accessoryView;
@end
