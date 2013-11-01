//
//  ViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "ViewController.h"
#import "TMCClient.h"

#define BASE_URL @"http://0.0.0.0:3000/" // dev
#define CURRENT_ISSUE_NUMBER @"current_issue_numbers.json"

#define current_issue_number_key @"current_issue_number"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:
//                             [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, CURRENT_ISSUE_NUMBER]]];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               // handle response
//                               NSLog(@"NSURLConnection - dataAsString: %@", [NSString stringWithUTF8String:[data bytes]]);
//                               NSError *error1;
//                               NSMutableDictionary *seralizedJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
//                               NSLog(@"NSURLConnection - seralizedJson: %@", seralizedJson);
//                           }];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, CURRENT_ISSUE_NUMBER]]
//            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                // handle response
//                NSLog(@"NSURLSession - dataAsString: %@", [NSString stringWithUTF8String:[data bytes]]);
//                NSError *error1;
//                NSMutableDictionary *seralizedJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
//                NSLog(@"NSURLSession - seralizedJson: %@", seralizedJson);
//            }] resume];
//    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:[NSString stringWithFormat:@"%@%@", BASE_URL, CURRENT_ISSUE_NUMBER] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"AFHTTPRequestOperationManager - JSON: %@", responseObject);
//        
//        if (responseObject) {
//            NSDictionary *responseObjectDict = (NSDictionary *)responseObject;
//            if ([responseObjectDict valueForKey:current_issue_number_key]) {
//                _currentIssueNumber = (NSNumber *)[responseObjectDict valueForKey:current_issue_number_key];
//                
//                NSLog(@"_currentIssueNumber: %@", _currentIssueNumber);
//                
//                if (_currentIssueNumber) {
//                    [self updateCurrentIssueNumberLabel:_currentIssueNumber];
//                }
//                
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

    NSURLSessionDataTask *task = [[TMCClient sharedClient] getCurrentIssueNumber:CURRENT_ISSUE_NUMBER
                                                                 completion:^(NSArray *results, NSError *error) {
                                                                     if (results) {
                                                                         NSLog(@"results: %@", results);
                                                                     } else {
                                                                         NSLog(@"ERROR: %@", error);
                                                                     }
                                                                 }];

    
}

- (void)updateCurrentIssueNumberLabel:(NSNumber *)currentIssueNumber {
    self.currentIssueNumberLabel.text = [NSString stringWithFormat:@"%@", currentIssueNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
