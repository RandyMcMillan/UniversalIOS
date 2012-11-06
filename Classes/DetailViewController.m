//
//  DetailViewController.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "MainParentView.h"

#import "WelcomeVC.h"

@implementation DetailViewController

@synthesize tblView;
@synthesize subcategories;

#pragma mark -
#pragma mark View lifecycle

- (void)loadView
{
	// The view underneath the tableView
    //REF: MainParentView.h/m for custom styling and events 
	MainParentView *mainParentView = [[MainParentView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [mainParentView useInitStyle];
    
    WelcomeVC *welcome = [[WelcomeVC alloc]initWithNibName:@"WelcomeVC" bundle:nil];
    welcome.view.center = mainParentView.center;
    //[welcome.view setFrame:CGRectMake(44,44,512,512)];
    [mainParentView addSubview:welcome.view];
    
	//mainParentView.backgroundColor = [UIColor colorWithRed:0.612 green:0.620 blue:0.678 alpha:1.000];

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
