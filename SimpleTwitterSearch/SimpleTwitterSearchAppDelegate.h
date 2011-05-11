//
//  SimpleTwitterSearchAppDelegate.h
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/11/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleTwitterSearchViewController;

@interface SimpleTwitterSearchAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SimpleTwitterSearchViewController *viewController;

@end
