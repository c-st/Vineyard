//
//  VYAddWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAddWineViewController.h"

@interface VYAddWineViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@end

@implementation VYAddWineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)nameWasEntered:(id)sender {
	[_doneButton setEnabled:[[_nameLabel text] length] > 0];
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
