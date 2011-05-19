//
//  SearchResults.h
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/16/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchResults : UITableViewController {
    NSMutableArray *tweets;
}

@property (nonatomic, retain) NSMutableArray *tweets;

@end

