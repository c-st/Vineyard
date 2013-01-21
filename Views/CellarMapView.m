#import "CellarMapView.h"
#import "MKMapView+ZoomLevel.h"
#import "OCAnnotation.h"

#import "UIImage+Scale.h"
#import "UIColor+CellarColours.h"



@implementation CellarMapView
@synthesize location, zoomLevel, deltaLatitude;

- (id) initWithFrame:(CGRect) frame {
	self = [super initWithFrame:frame];
    if (self) {
		[self setDelegate:self];
		
		//[self setWinesToBeDisplayed:[Wine findAll]];
		
		[self setClusteringMethod:OCClusteringMethodGrid];
		[self setClusteringEnabled:YES];
		[self setClusterSize:0.2];
    }
    return self;
}

- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation andZoomLevel:(int)theZoomLevel{
	self = [super initWithFrame:frame];
    if (self) {
		self.location = rootLocation;
		self.zoomLevel = theZoomLevel;
		[self setCenterCoordinate:location zoomLevel:zoomLevel animated:YES];
    }
    return self;
}


- (void) setWinesToBeDisplayed:(NSArray*) wines {
	[self removeAnnotations:self.annotations];
	for (Wine* wine in wines) {
		//CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(wine.location.latitudeValue, wine.location.longitudeValue);
		CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(wine.appellation.region.location.latitudeValue, wine.appellation.region.location.longitudeValue);
		MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
		[point setCoordinate:loc];
		OCAnnotation *annotation = [[OCAnnotation alloc] initWithAnnotation:point];
		[self addAnnotation:annotation];
	}
	[self doClustering];
}

#pragma mark - map delegate methods

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated {
    [self removeOverlays:self.overlays];
    [self doClustering];
}

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView;
	
    // if it's a cluster
    if ([annotation isKindOfClass:[OCAnnotation class]]) {
		static NSString *kClusterView = @"kClusterView";
		
        OCAnnotation *clusterAnnotation = (OCAnnotation *)annotation;
		
        annotationView = (MKAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:kClusterView];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kClusterView];
            annotationView.canShowCallout = YES;
            annotationView.centerOffset = CGPointMake(0, 0);
        }
        //calculate cluster region
        //CLLocationDistance clusterRadius = self.region.span.longitudeDelta * self.clusterSize * 111000 / 2.0f; //static circle size of cluster
        CLLocationDistance clusterRadius = self.region.span.longitudeDelta/log(self.region.span.longitudeDelta*self.region.span.longitudeDelta) * log(pow([clusterAnnotation.annotationsInCluster count], 4)) * self.clusterSize * 50000; //circle size based on number of annotations in cluster
		
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:clusterAnnotation.coordinate radius:clusterRadius * cos([annotation coordinate].latitude * M_PI / 180.0)];
        [circle setTitle:@"background"];
        [self addOverlay:circle];
		
        // set its image
        annotationView.image = [[UIImage imageNamed:@"wine_bottle_normal"] scaleToSize:CGSizeMake(30, 30)];
		
        // change pin image for group
        if (self.clusterByGroupTag) {
            clusterAnnotation.title = clusterAnnotation.groupTag;
        }
    }
	
	return annotationView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKCircle *circle = overlay;
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
	
    if ([circle.title isEqualToString:@"background"]) {
        circleView.fillColor = [[UIColor cellarWineRedColour] colorWithAlphaComponent:0.4f];
        circleView.strokeColor = [UIColor blackColor];
        circleView.lineWidth = 0.5;
    }
    else if ([circle.title isEqualToString:@"helper"]) {
        circleView.fillColor = [UIColor redColor];
        circleView.alpha = 0.25;
    }
    else {
        circleView.strokeColor = [UIColor blackColor];
        circleView.lineWidth = 0.5;
    }
	
    return circleView;
}



@end
