//
//  DetailViewController.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize tblView;
@synthesize subcategories;

#pragma mark -
#pragma mark View lifecycle

- (void)loadView
{
	// The view underneath the tableView
	UIView *mainParentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

	mainParentView.backgroundColor = [UIColor blueColor];

	self.tblView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

	self.tblView.dataSource = self;
	self.tblView.delegate	= self;

	self.view = mainParentView;

	// /hide the tableView initially to present a welcome view
	self.tblView.alpha = 0.0;

	[self.view addSubview:self.tblView];

	self.view.autoresizingMask		= UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.autoresizesSubviews	= YES;
}

- (void)viewDidLoad
{
	[self populateTable];

	[super viewDidLoad];
}

- (void)viewDidUnload
{
	self.subcategories = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.subcategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	cell.textLabel.text = [[self.subcategories objectAtIndex:indexPath.row] objectForKey:@"name"];

	return cell;
}

// - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  /**
//   * subclass handles this
//   */
// }

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
	self.subcategories = nil;

	[super didReceiveMemoryWarning];
}

- (void)populateTable
{
	if (self.subcategories == nil) {
		Model *subcats = [[Model alloc] init];

		self.subcategories = subcats.firstDetail;

		[self.tblView reloadData];
	} else {
		[self.tblView reloadData];
	}
}

@end
