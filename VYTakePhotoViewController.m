//
//  VYTakePhotoViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 05.03.14.
//  Copyright (c) 2014 Christian Stangier. All rights reserved.
//

#import "VYTakePhotoViewController.h"

@interface VYTakePhotoViewController ()


@end

@implementation VYTakePhotoViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	
	
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
															  message:@"Device has no camera"
															 delegate:nil
													cancelButtonTitle:@"OK"
													otherButtonTitles: nil];
        [myAlertView show];
		_alreadyPresented = YES;
		[self dismissViewControllerAnimated:NO completion:nil];
    } else {
		picker.delegate = self;
		picker.allowsEditing = YES;
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[picker setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
	}
	
	if (!_alreadyPresented) {
		[self presentViewController:picker animated:YES completion:NULL];
	}
	_alreadyPresented = YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self setWineImage:info[UIImagePickerControllerEditedImage]];
	[self performSegueWithIdentifier:@"unwindToAddWineController" sender:self];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:^{
		[self dismissViewControllerAnimated:NO completion:nil];
	}];
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);

	if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
		VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
		// save full sized image
		NSData *imageData = UIImagePNGRepresentation([self wineImage]);
		[addEditWineController.wine setImage:imageData];
		
		// generate thumbnail
		NSData *thumbnailData = UIImagePNGRepresentation([self.wineImage thumbnailImage:150
																	  transparentBorder:0
																		   cornerRadius:0
																   interpolationQuality:kCGInterpolationDefault]);
		
		[addEditWineController.wine setImageThumbnail:thumbnailData];
	}
}

@end
