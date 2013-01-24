#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import <MapKit/MapKit.h>

#import "CellarMapView.h"
#import "SVSegmentedControl.h"

@interface WineMapFoldViewController : UIViewController {
	CellarMapView *mapView;
	SVSegmentedControl *segmentedControl;
	
}

@property (nonatomic, strong) CellarMapView *mapView;
@property (nonatomic, strong) SVSegmentedControl *segmentedControl;

- (void) setWines:(NSArray *)wines;

@end
