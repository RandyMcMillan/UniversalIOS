//
//  RootViewController.h
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

#import "UIImage+PDF.h"

@class Reachability;

@interface RootViewController : UITableViewController
{


    Reachability    *hostReach;
    Reachability    *internetReach;
    Reachability    *wifiReach;


}
@end
