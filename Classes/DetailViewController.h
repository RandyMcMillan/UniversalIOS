//
//  DetailViewController.h
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

#import "UIImage+PDF.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView	*tblView;
@property (nonatomic, copy) NSArray			*subcategories;

- (void)populateTable;

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;


@end
