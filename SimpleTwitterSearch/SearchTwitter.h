//
//  SearchTwitter.h
//  SimpleTwitterSearch
//
//  Created by Adam St. Onge on 5/11/11.
//  Copyright 2011 Remarkable Pixels. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchTwitter : NSObject {
    NSMutableData *tweetBlob;
}

- (void)grabData:(NSString *)searchTerm;


@end
