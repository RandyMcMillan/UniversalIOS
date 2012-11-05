//
//  main.m
//  UniversalExample
//
//  Created by Cory Wiles on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversalExampleAppDelegate_Phone.h"
#import "UniversalExampleAppDelegate_Pad.h"

int main(int argc, char *argv[]) {

  @autoreleasepool {

    if (IS_IPAD()) {
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([UniversalExampleAppDelegate_Pad class]));
    } else {
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([UniversalExampleAppDelegate_Phone class]));
    }
  }
}
