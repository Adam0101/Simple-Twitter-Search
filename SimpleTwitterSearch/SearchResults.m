//
//  SearchResults.m
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/16/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import "SearchResults.h"


@implementation SearchResults

@synthesize tweets;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -
#pragma mark Notification handler

// Get notification from SearchTwitter, that the array of urls 
// matching the search term and our dictionary of known image sites is ready to go
- (void)recvTwitterResults:(NSNotification *)notification {
	if([notification userInfo]==nil){
        UIAlertView *twitterViewAlertView = [[UIAlertView alloc] initWithTitle:@"Twitter Search" 
                                                                       message:@"No Results Found" 
                                                                      delegate:self
                                                             cancelButtonTitle:@"Try Again"
                                                             otherButtonTitles:@"Cancel",nil];
        [twitterViewAlertView show];
        [twitterViewAlertView release];
	}
	else {        
		// Unpack the passed dictionary from nsnotifications
		NSDictionary *unpackDict = [notification userInfo];
        
		// Take out the array with links
		//NSMutableArray *tweets = [unpackDict objectForKey:@"array"];
		[self setTweets:[unpackDict objectForKey:@"array"]];
        
        [[self tableView]reloadData];
	}
	
	
}

- (void)twitterError:(NSNotification *)notification {
	UIAlertView *twitterViewAlertView = [[UIAlertView alloc] initWithTitle:@"Twitter Search" 
                                                                   message:@"Twitter search failed" 
                                                                  delegate:self
                                                         cancelButtonTitle:@"Try Again"
                                                         otherButtonTitles:@"Cancel",nil];
    [twitterViewAlertView show];
    [twitterViewAlertView release];
	
}

- (void)dealloc
{
    [tweets dealloc];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Setup NSNotification center to listen for response back from Asynch twitter search
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	// Listen for call to twitterSearchDone, and then run function recvTwitterResults 
	[nc addObserver:self selector:@selector(recvTwitterResults:) name:@"twitterSearchDone" object:nil];
	[nc addObserver:self selector:@selector(twitterError:) name:@"twitterFail" object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self tweets]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }  
    
    NSDictionary *tweet = (NSDictionary *)[tweets objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[tweet objectForKey:@"text"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"User: %@",[tweet objectForKey:@"from_user"]];
    NSLog(@"cell text %@",[tweet objectForKey:@"from_user"]);
    
    return cell;
}


@end
