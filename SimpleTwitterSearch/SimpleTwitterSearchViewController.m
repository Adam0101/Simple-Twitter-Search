//
//  SimpleTwitterSearchViewController.m
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/11/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import "SimpleTwitterSearchViewController.h"
#import "SearchTwitter.h"


@implementation SimpleTwitterSearchViewController

- (void)dealloc
{
    [searchTheTweets release];
    [super dealloc];
}

- (SearchTwitter *)searchTheTweets {
    if(!searchTheTweets) {
        searchTheTweets = [[SearchTwitter alloc] init];
    }
    return searchTheTweets;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
       
}

#pragma mark -
#pragma mark Button action
- (void)goSearch {
    //go grab the data from searchTwitter class
    [[self searchTheTweets] grabData:[searchTerm text]];
    
    SearchResults *viewController = [[SearchResults alloc] initWithNibName:@"SearchResults" bundle:[NSBundle mainBundle]];
    //viewController.delegate = self;
      
    [viewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:viewController animated:YES];
    
    //[self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
    viewController = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
