//
//  WelcomeVC.m
//  UniversalExample
//
//  Created by Randy McMillan on 11/5/12.
//
//

#import "WelcomeVC.h"

@interface WelcomeVC () {}

@end

@implementation WelcomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {
		// Custom initialization
	}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage originalSizeImageWithPDFNamed:@"Icon512x512.pdf"]];
	imageView.center = self.view.center;
	[self.view addSubview:imageView];
	// [ imageView release ];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
