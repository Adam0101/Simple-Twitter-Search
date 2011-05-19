//
//  SearchTwitter.m
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/11/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import "SearchTwitter.h"
#import "JSON.h"

@implementation SearchTwitter


- (void)grabData:(NSString *)searchTerm {
    
	// Setup an error to catch stuff in 
	NSError *error = NULL;
	
	//Create the regular expression to match against whitespace or % or ^
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\s|%|^)" 
																		   options:NSRegularExpressionCaseInsensitive 
																			 error:&error];
	
	//Create the regular expression to match against hash tags
	NSRegularExpression *regexHash = [NSRegularExpression regularExpressionWithPattern:@"#" 
                                                                               options:NSRegularExpressionCaseInsensitive 
                                                                                 error:&error];
	
	// create the new string by replacing the matching of the regex pattern with the template pattern(whitespace)
	NSString *tempString = [regex stringByReplacingMatchesInString:searchTerm options:0 
                                                             range:NSMakeRange(0, [searchTerm length]) 
                                                      withTemplate:@"%20"];
	
	// create the new string by replacing the matching of the regex pattern with the template pattern(whitespace)
	NSString *hashTempString = [regexHash stringByReplacingMatchesInString:tempString options:0 
                                                                     range:NSMakeRange(0, [searchTerm length]) 
                                                              withTemplate:@"%23"];
	searchTerm = hashTempString;
	
    // Build the string to search against the twitter search api
    NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=&ands=%@&phrase=&rpp=50",searchTerm];
    
	NSURL *url = [NSURL URLWithString:urlString];
	
	//Setup and start async download
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection release];
	[request release];
    
	searchTerm = nil;
}

// Gather up all the asynch data as it comes in and store it in the blob
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Check to see if this is a new search, if so it will be nil, so create an object
    
	if(tweetBlob == nil) {
		tweetBlob = [[NSMutableData alloc]init];
		[tweetBlob appendData:data];
	}
	else {
		[tweetBlob appendData:data];
	}
	
}

// Once the data is complete, then we can parse it
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	// Store data blob we got back from twitter into a JSON string
	NSString *jsonString = [[NSString alloc] initWithData:tweetBlob encoding:NSUTF8StringEncoding];
		
	//Now use the Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
	// Build an Array from the dictionary for easy access to each entry
	NSDictionary *tweets = [results objectForKey:@"results"];
    
	// Handle any errors that come from twitter in json, e.g. {"error":"page parameter out of range"}
	if(tweets) {
        NSDictionary *dictToBePassed = [NSDictionary dictionaryWithObject:tweets forKey:@"array"];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter postNotificationName:@"twitterSearchDone"
										  object:nil
										userInfo:dictToBePassed];
	}
	else {
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter postNotificationName:@"twitterFail"
										  object:nil
										userInfo:nil];
	}
    
	[jsonString release];
	jsonString = nil;
	tweetBlob = nil;
}


- (void)dealloc {
    [tweetBlob release];
    [super dealloc];
}

@end
