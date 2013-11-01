//
//  TMCClient.h
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 11/1/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TMCClient : AFHTTPSessionManager

+ (TMCClient *)sharedClient;
- (NSURLSessionDataTask *)getCurrentIssueNumber:(NSString *)issueNumber completion:( void (^)(NSArray *results, NSError *error) )completion;

@end
