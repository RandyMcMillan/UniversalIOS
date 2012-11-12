//
//  RootViewController.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Reachability.h"
#import  "CellButton.h"

@interface RootViewController () {}

@end

@implementation RootViewController

- (void)viewDidLoad
{
   
#define ROW_HEIGHT 80
    self.tableView.rowHeight = ROW_HEIGHT;

	NSDictionary	*appInfo	= [[NSBundle mainBundle] infoDictionary];
	NSString		*versionStr = [NSString stringWithFormat:@"build (%@)", [appInfo objectForKey:@"GitTag"]];

	NSLog(@"--------- versionStr = %@ -----------", versionStr);
	NSLog(@"--------- versionStr = %@ -----------", versionStr);
	NSLog(@"--------- versionStr = %@ -----------", versionStr);

	[super viewDidLoad];

	// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
	// method "reachabilityChanged" will be called.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

	// Change the host name here to change the server your monitoring
	// self.detailDescriptionLabel.text = [NSString stringWithFormat: @"Remote Host: %@", @"www.apple.com"];
	hostReach = [Reachability reachabilityWithHostName:@"youtube.com"];
	[hostReach startNotifier];
	[self updateInterfaceWithReachability:hostReach];

	internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability:internetReach];

	wifiReach = [Reachability reachabilityForLocalWiFi];
	[wifiReach startNotifier];
	[self updateInterfaceWithReachability:wifiReach];
}

#pragma mark - updateInterfaceWithReachability

- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
	NSLog(@"updateInterfaceWithReachability = %@", curReach);

	if (curReach == hostReach) {
		NetworkStatus	netStatus			= [curReach currentReachabilityStatus];
		BOOL			connectionRequired	= [curReach connectionRequired];

		if (connectionRequired) {
			NSLog(@"connectionRequired = %s", connectionRequired ? "true" : "false");
			NSLog(@"network is available.\n  Internet traffic will be routed through it after a connection is established.");
		} else {
			NSLog(@"connectionRequired = %s", connectionRequired ? "true" : "false");
			NSLog(@"Cellular data network is active.\n  Internet traffic will be routed through it.");
		}

		NSLog(@"netStatus = %i", netStatus);

		if (netStatus == 0) {
			NSLog(@"netStatus = 0");
		}

		if (netStatus > 0) {
			NSLog(@"netStatus = 1");
		}

		if (netStatus > 1) {
			NSLog(@"netStatus = 2");
		}
	}

	if (curReach == internetReach) {
		NSLog(@"internetReach");
	}

	if (curReach == wifiReach) {
		NSLog(@"wifiReach");
	}
}

#pragma mark - reachabilityChanged

// Called by Reachability whenever status changes.
- (void)reachabilityChanged:(NSNotification *)note
{
	Reachability *curReach = [note object];

	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}


#pragma mark -
#pragma mark Configuring table view cells

#define NAME_TAG 1
#define TIME_TAG 2
#define IMAGE_TAG 3

#define LEFT_COLUMN_OFFSET 70.0
#define LEFT_COLUMN_WIDTH 160.0

#define MIDDLE_COLUMN_OFFSET 170.0
#define MIDDLE_COLUMN_WIDTH 90.0

#define RIGHT_COLUMN_OFFSET 280.0

#define MAIN_FONT_SIZE 20.0
#define LABEL_HEIGHT 20.0

#define IMAGE_SIDE 30.0



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
  
	/*
	 Create labels for the text fields; set the highlight color so that when the cell is selected it changes appropriately.
     */

	UILabel *label;
	CGRect rect;
	
	// Create a label for the time zone name.
	
    //rect = CGRectMake(LEFT_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, LEFT_COLUMN_WIDTH, LABEL_HEIGHT);
	rect = CGRectMake(LEFT_COLUMN_OFFSET, ROW_HEIGHT/4, LEFT_COLUMN_WIDTH, LABEL_HEIGHT);
    label = [[UILabel alloc] initWithFrame:rect];
	label.tag = NAME_TAG;
	label.font = [UIFont boldSystemFontOfSize:MAIN_FONT_SIZE];
	label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
	//[label release];
    
    //cell.imageView.image = [UIImage imageNamed:@"icon.png"];
    // cell.imageView.image = imageView.image;
    //[ imageView release ];

	cell.textLabel.text = @"Root";
    label.text = cell.textLabel.text;
	cell.textLabel.text = (indexPath.row) == 0 ? @"First Detail" : @"Second Detail";
    
    /* Draw a growing line of buttons to demonstate the scaling
	 */
	float kInset = 4;
	float kSpacing = 10;
	float buttonY = kSpacing;
    
	for( float i = 0; i < 1; i++ )
	{
		/* Always round up coordinates before passing them into UIKit
		 */
		float buttonWidth = ceilf( 22 * sqrtf( i + 1 ));
		
		CGSize buttonSize = CGSizeMake( buttonWidth+40, buttonWidth+40 );
		CellButton *yingYangButton = [ CellButton buttonWithType:UIButtonTypeCustom ];
        [yingYangButton useInitStyle];
		yingYangButton.enabled = FALSE;//allow touch events to pass thru
        yingYangButton.frame = CGRectMake( kSpacing, buttonY, buttonSize.width, buttonSize.height );
		
		/* Inset the button image
		 */
		CGSize imageSize = CGSizeMake( buttonSize.width - kInset * 2, buttonSize.height - kInset * 2 );
		
		/* Set the button image from the PDF asset.
		 */
        [ yingYangButton setImage:[ UIImage imageWithPDFNamed:@"Icon512x512.pdf" atSize:imageSize ] forState:UIControlStateNormal ];
        
        [yingYangButton addSubview:label];
        //[ self.view addSubview:yingYangButton ];
		[cell.contentView addSubview:yingYangButton];
		buttonY += buttonWidth + kSpacing;

	}
    
    //cell.textLabel.textColor = [UIColor colorWithRed:0.122 green:0.129 blue:0.161 alpha:0.000];
    //label.textColor = [UIColor blackColor];
    //label.highlightedTextColor = [UIColor whiteColor];
    label.text = cell.textLabel.text;
    cell.textLabel.text = nil;
 	return cell;
}

#pragma mark -
#pragma mark Table view delegate

// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  /**
//   * subclass handles this
//   */
// }

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
