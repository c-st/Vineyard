//
//  VYScrollView.m
//  Vineyard
//
//  Created by Christian Stangier on 01.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYScrollView.h"

@implementation VYScrollView

@synthesize footerView, headerView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setDelegate:(id<VYScrollViewDelegate, UIScrollViewDelegate>)newDelegate {
	if (newDelegate != (id<VYScrollViewDelegate, UIScrollViewDelegate>) self) {
		externalDelegate = newDelegate;
	}
	
	[super setDelegate:self];
}

# pragma mark Implementing and forwarding UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//NSLog(@"scrollViewDidSCroll");
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
		[externalDelegate scrollViewDidScroll:scrollView];
	}
	
	// ...
	if (!scrollView.dragging) return;
	
	
	if (scrollView.contentOffset.y > 0) { // dragging up
		if (scrollView.contentOffset.y > 120) {
			if (_footerLoaded) return;
			if ([externalDelegate respondsToSelector:@selector(footerLoadedInScrollView:)]) {
				[externalDelegate performSelector:@selector(footerLoadedInScrollView:) withObject:self];
			}
			_footerLoaded = YES;
		} else {
			if (!_footerLoaded) return;
			if ([externalDelegate respondsToSelector:@selector(footerUnloadedInScrollView:)]) {
				[externalDelegate performSelector:@selector(footerUnloadedInScrollView:) withObject:self];
			}
			_footerLoaded = NO;
		}
	} else { // dragging down
		if (scrollView.contentOffset.y < - 20) {
			if (_headerLoaded) return;
			if ([externalDelegate respondsToSelector:@selector(headerLoadedInScrollView:)]) {
				[externalDelegate performSelector:@selector(headerLoadedInScrollView:) withObject:self];
			}
			_headerLoaded = YES;
			
		} else {
			if (!_headerLoaded) return;
			if ([externalDelegate respondsToSelector:@selector(headerUnloadedInScrollView:)]) {
				[externalDelegate performSelector:@selector(headerUnloadedInScrollView:) withObject:self];
			}
			_headerLoaded = NO;
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
		[externalDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	}
	
	if (_footerLoaded && !_accessoryViewActive) {
		[self pushViewUp];
	} else if(_headerLoaded && _accessoryViewActive) {
		[self pushViewDown];
	}
}


- (void)pushViewUp {
	[self setAccessoryView:[externalDelegate accessoryViewForScrollView:self]];
	[self.accessoryView setFrame: CGRectMake(0,
										self.accessoryView.frame.size.height + self.contentOffset.y,
										self.accessoryView.frame.size.width,
										self.accessoryView.frame.size.height)];
	
	[self addSubview:self.accessoryView];
	[[self footerView] setHidden:YES];
	
	[UIView animateWithDuration:.3 animations:^{
		[self.accessoryView setFrame:CGRectMake(self.frame.origin.x,
												40,//self.frame.origin.y,
												self.accessoryView.frame.size.width,
												self.accessoryView.frame.size.height +1)];
		[self setContentOffset:CGPointMake(0, 0)];
		
	} completion:^(BOOL finished) {
	}];
	
	_accessoryViewActive = YES;
}

- (void) pushViewDown {
	[UIView animateWithDuration:.3 animations:^{
		[self.accessoryView setFrame:CGRectMake(0,
												self.accessoryView.frame.size.height + self.contentOffset.y,
												self.frame.size.width,
												self.frame.size.height)];
	} completion:^(BOOL finished) {
		[self.accessoryView removeFromSuperview];
		
		[[self footerView] setHidden:NO];
	}];
	
	_accessoryViewActive = NO;
}


# pragma mark Simply forwarding to external UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
		[externalDelegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
		[externalDelegate scrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
		[externalDelegate scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
		[externalDelegate scrollViewDidEndScrollingAnimation:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
		return [externalDelegate viewForZoomingInScrollView:scrollView];
	else
		return nil;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
		[externalDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
		return [externalDelegate scrollViewShouldScrollToTop:scrollView];
	else
		return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
	if ([externalDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
		[externalDelegate scrollViewDidScrollToTop:scrollView];
}



@end
