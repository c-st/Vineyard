#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "Wine.h"
#import "Location.h"
#import "Region.h"
#import "Appellation.h"

#import "SwipeView.h"
#import "CellarMapView.h"

@interface WineDetailViewController : UIViewController <UIScrollViewDelegate, SwipeViewDelegate, SwipeViewDataSource> {
	Wine *wine;
	
	SwipeView *swipeView;
	UIPageControl *pageControl;
	UILabel *pageLabel;
	
	CellarMapView *locationMapView;
	CellarMapView *addedMapView;
}

@property (nonatomic, strong) Wine *wine;

@property (nonatomic, strong) SwipeView	*swipeView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *pageLabel;

@property (nonatomic, strong) CellarMapView	*locationMapView;
@property (nonatomic, strong) CellarMapView *addedMapView;

- (id) initWithWine:(Wine *) theWine;

@end
