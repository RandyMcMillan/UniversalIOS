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
#import "Constants.h"

@implementation DetailViewController

@synthesize tblView;
@synthesize subcategories;

#define ROW_HEIGHT 276

#pragma mark -
#pragma mark View lifecycle

- (void)loadView
{
	// The view underneath the tableView
	// REF: MainParentView.h/m for custom styling and events
	MainParentView *mainParentView = [[MainParentView alloc] initWithFrame:[UIScreen mainScreen].bounds];

	[mainParentView useInitStyle];

	WelcomeVC *welcome = [[WelcomeVC alloc] initWithNibName:@"WelcomeVC" bundle:nil];
	welcome.view.center = mainParentView.center;
	// [welcome.view setFrame:CGRectMake(44,44,512,512)];
	[mainParentView addSubview:welcome.view];

	// mainParentView.backgroundColor = [UIColor colorWithRed:0.612 green:0.620 blue:0.678 alpha:1.000];

	self.tblView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

	self.tblView.dataSource = self;
	self.tblView.delegate	= self;

	self.view = mainParentView;

	// /hide the tableView initially to present a welcome view
	self.tblView.alpha = 0.0;

	if (IS_IPAD()) {
		self.tblView.rowHeight = ROW_HEIGHT + 80;
	} else {
		self.tblView.rowHeight = ROW_HEIGHT;
	}

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

	/* Draw a growing line of buttons to demonstate the scaling
	 */
	float	kInset		= 4;
	float	kSpacing	= 10;
	float	buttonY		= kSpacing;

	for (float i = 0; i < 1; i++) {
		/* Always round up coordinates before passing them into UIKit
		 */
		float imageWidth = ceilf(22 * sqrtf(i + 1));

		if (IS_IPAD()) {
			CGSize imageSize1 = CGSizeMake(imageWidth + 300, imageWidth + 300 /*the height*/);
			// Inset the button image
			CGSize imageSize2 = CGSizeMake(imageSize1.width - kInset * 2, imageSize1.height - kInset * 2);
			buttonY += imageWidth + kSpacing;
			cell.imageView.image = [UIImage imageWithPDFNamed:@"Icon512x512.pdf" atSize:imageSize2];
		} else {
			CGSize imageSize1 = CGSizeMake(imageWidth + 140, imageWidth + 140 /*the height*/);
			// Inset the button image
			CGSize imageSize2 = CGSizeMake(imageSize1.width - kInset * 2, imageSize1.height - kInset * 2);
			buttonY += imageWidth + kSpacing;
			cell.imageView.image = [UIImage imageWithPDFNamed:@"Icon512x512.pdf" atSize:imageSize2];
		}

		buttonY += imageWidth + kSpacing;

		//    cell.imageView.image = [UIImage imageWithPDFNamed:@"Icon512x512.pdf" atSize:imageSize2];
	}

	//    cell.imageView.image = [UIImage imageNamed:@"icon.png"];

	return cell;
}

#pragma mark -
#pragma mark Configuring table view cells

#define NAME_TAG				1
#define TIME_TAG				2
#define IMAGE_TAG				3

#define LEFT_COLUMN_OFFSET		10.0
#define LEFT_COLUMN_WIDTH		160.0

#define MIDDLE_COLUMN_OFFSET	170.0
#define MIDDLE_COLUMN_WIDTH		90.0

#define RIGHT_COLUMN_OFFSET		280.0

#define MAIN_FONT_SIZE			18.0
#define LABEL_HEIGHT			26.0

#define IMAGE_SIDE				30.0

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier
{
	/*
	 *   Create an instance of UITableViewCell and add tagged subviews for the name, local time, and quarter image of the time zone.
	 */

	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

	/*
	 *   Create labels for the text fields; set the highlight color so that when the cell is selected it changes appropriately.
	 */
	UILabel *label;
	CGRect	rect;

	// Create a label for the time zone name.
	rect		= CGRectMake(LEFT_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, LEFT_COLUMN_WIDTH, LABEL_HEIGHT);
	label		= [[UILabel alloc] initWithFrame:rect];
	label.tag	= NAME_TAG;
	label.font	= [UIFont boldSystemFontOfSize:MAIN_FONT_SIZE];
	label.adjustsFontSizeToFitWidth = YES;
	// [cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];

	/*
	 *   // Create a label for the time.
	 *    rect				= CGRectMake(MIDDLE_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
	 *    label				= [[UILabel alloc] initWithFrame:rect];
	 *    label.tag			= TIME_TAG;
	 *    label.font			= [UIFont systemFontOfSize:MAIN_FONT_SIZE];
	 *    label.textAlignment = UITextAlignmentRight;
	 *    [cell.contentView addSubview:label];
	 *    label.highlightedTextColor = [UIColor whiteColor];
	 */

	// Create an image view for the quarter image.
	rect = CGRectMake(RIGHT_COLUMN_OFFSET, (ROW_HEIGHT - IMAGE_SIDE) / 2.0, IMAGE_SIDE, IMAGE_SIDE);

	UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.tag = IMAGE_TAG;
	[cell.contentView addSubview:imageView];

	return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
	/*
	 *   Cache the formatter. Normally you would use one of the date formatter styles (such as NSDateFormatterShortStyle), but here we want a specific format that excludes seconds.
	 */
	static NSDateFormatter *dateFormatter = nil;

	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"h:mm a"];
	}

	UILabel *label;

	// Set the locale name.
	label		= (UILabel *)[cell viewWithTag:NAME_TAG];
	label.text	= @"label.text";

	// Set the time.
	label		= (UILabel *)[cell viewWithTag:TIME_TAG];
	label.text	= [dateFormatter stringFromDate:[NSDate date]];

	// Set the image.
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
	imageView.image = nil;
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
