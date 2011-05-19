//
//  SimpleTwitterSearchViewController.h
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/11/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTwitter.h"
#import "SearchResults.h"

@interface SimpleTwitterSearchViewController : UIViewController {
    SearchTwitter *searchTheTweets;
    
    IBOutlet UIButton *searchButton;
    IBOutlet UITextField *searchTerm;
}

-(IBAction)goSearch;


@end
