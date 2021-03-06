//
//  RootViewController_Pad.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController_Pad.h"

@implementation RootViewController_Pad

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];

	if (self) {}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

	UniversalExampleAppDelegate_Pad *delegate				= [[UIApplication sharedApplication] delegate];
	DetailViewController_Pad		*detailViewController	= (DetailViewController_Pad *)[delegate.splitViewController.viewControllers objectAtIndex:1];

	Model *model = [[Model alloc] init];

	if (indexPath.row == 0) {
		detailViewController.subcategories = model.firstDetail;
	} else {
		detailViewController.subcategories = model.secondDetail;
	}

	[detailViewController populateTable];

	// /unhide tableview and hide welcomview
	[UIView animateWithDuration :0.3// snappy
			delay				:0.0
			options				:UIViewAnimationCurveEaseInOut
			animations			:^{
			detailViewController.tblView.alpha = 1.0;
		}
			completion			:^(BOOL finished) {}
	];
}

@end
