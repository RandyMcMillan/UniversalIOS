//
//  RootViewController.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "Reachability.h"

@interface RootViewController () {}

@end

@implementation RootViewController

- (void)viewDidLoad
{
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	cell.textLabel.text = @"Root";

	cell.textLabel.text = (indexPath.row) == 0 ? @"First Detail" : @"Second Detail";

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
