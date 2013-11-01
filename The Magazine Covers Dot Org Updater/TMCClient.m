//
//  TMCClient.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 11/1/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "AFNetworking.h"
#import "TMCClient.h"

#define BASE_URL @"http://0.0.0.0:3000/" // dev
#define CURRENT_ISSUE_NUMBER @"current_issue_numbers.json"

@implementation TMCClient

+ (TMCClient *)sharedClient {
    static TMCClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:BASE_URL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[TMCClient alloc] initWithBaseURL:baseURL
                                      sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

- (NSURLSessionDataTask *)getCurrentIssueNumber:(NSString *)issueNumber completion:( void (^)(NSArray *results, NSError *error) )completion {
    NSURLSessionDataTask *task = [self GET:issueNumber
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject, nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
}

@end
