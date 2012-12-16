#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

#import "Wine.h"
#import "Location.h"

@interface WineDetailViewController : UIViewController <UIScrollViewDelegate> {
	Wine *wine;
	
	MKMapView *mapView;
}

@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) MKMapView	*mapView;

- (id) initWithWine:(Wine *) theWine;

@end
