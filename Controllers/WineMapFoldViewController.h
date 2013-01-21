#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import <MapKit/MapKit.h>

#import "CellarMapView.h"

@interface WineMapFoldViewController : UIViewController {
	CellarMapView *mapView;
}

@property (nonatomic, strong) CellarMapView *mapView;

@end
