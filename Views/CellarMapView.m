#import "CellarMapView.h"
#import "MKMapView+ZoomLevel.h"
#import "OCAnnotation.h"

#import "UIImage+Scale.h"
#import "UIColor+CellarColours.h"



@implementation CellarMapView
@synthesize location, zoomLevel, deltaLatitude, wines;

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


- (void) setWinesToBeDisplayed:(NSArray*) theWines showRegion:(BOOL) isShowRegion{
	[self removeAnnotations:self.annotations];
	[self removeOverlays:self.overlays];
	self.wines = theWines;
	
	for (Wine* wine in theWines) {
		MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
		[point setCoordinate:[self getCoordinateFromWine:wine showRegion:isShowRegion]];
		OCAnnotation *annotation = [[OCAnnotation alloc] initWithAnnotation:point];
		[self addAnnotation:annotation];
	}
	[self centerMapForWines:isShowRegion];
	[self doClustering];
}

- (void) centerMapForWines: (BOOL) isShowRegion {
	Wine *firstWine = self.wines[0];
	CLLocationCoordinate2D coordinate = [self getCoordinateFromWine:firstWine showRegion:isShowRegion];
	
	double max_long = coordinate.longitude;
	double min_long = coordinate.longitude;
	double max_lat = coordinate.latitude;
	double min_lat = coordinate.latitude;
	
	for (Wine *wine in self.wines) {
		coordinate = [self getCoordinateFromWine:wine showRegion:isShowRegion];
		
		if (coordinate.latitude > max_lat) {max_lat = coordinate.latitude;}
		if (coordinate.latitude < min_lat) {min_lat = coordinate.latitude;}
		if (coordinate.longitude > max_long) {max_long = coordinate.longitude;}
		if (coordinate.longitude < min_long) {min_long = coordinate.longitude;}
	}
	
	//calculate center of map
	double center_long = (max_long + min_long) / 2;
	double center_lat = (max_lat + min_lat) / 2;
	
	//calculate deltas
	double deltaLat = abs(max_lat - min_lat);
	double deltaLong = abs(max_long - min_long);
	
	//set minimal delta
	if (deltaLat < 5) {deltaLat = 5;}
	if (deltaLong < 5) {deltaLong = 5;}
	
	//debug
	NSLog(@"center long: %f, center lat: %f", center_long, center_lat);
	NSLog(@"max_long: %f, min_long: %f, max_lat: %f, min_lat: %f", max_long, min_long, max_lat, min_lat);
	
	//create new region and set map
	CLLocationCoordinate2D coord = {.latitude =  center_lat, .longitude =  center_long};
	MKCoordinateSpan span = MKCoordinateSpanMake(deltaLat, deltaLong);
	MKCoordinateRegion region = {coord, span};
	
	[self setRegion:region animated:YES];
}

- (CLLocationCoordinate2D) getCoordinateFromWine:(Wine *)wine showRegion:(BOOL) isShowRegion {
	CLLocationCoordinate2D loc;
	if (isShowRegion) {
		loc = CLLocationCoordinate2DMake(wine.appellation.region.location.latitudeValue, wine.appellation.region.location.longitudeValue);
	} else {
		loc = CLLocationCoordinate2DMake(wine.location.latitudeValue, wine.location.longitudeValue);
	}
	return loc;
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
