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
    
    NSURLSessionDataTask *task = [[TMCClient sharedClient] getCurrentIssueNumber:CURRENT_ISSUE_NUMBER
                                                                      completion:^(NSArray *results, NSError *error) {
                                                                          if (results) {
                                                                              NSLog(@"results: %@", results);
                                                                              
                                                                              
                                                                              if (results) {
                                                                                  NSDictionary *responseObjectDict = (NSDictionary *)results;
                                                                                  if ([responseObjectDict valueForKey:current_issue_number_key]) {
                                                                                      _currentIssueNumber = (NSNumber *)[responseObjectDict valueForKey:current_issue_number_key];
                                                                                      
                                                                                      NSLog(@"_currentIssueNumber: %@", _currentIssueNumber);
                                                                                      
                                                                                      if (_currentIssueNumber) {
                                                                                          [self updateCurrentIssueNumberLabel:_currentIssueNumber];
                                                                                      }
                                                                                      
                                                                                  }
                                                                              }
                                                                              
                                                                              
                                                                          } else {
                                                                              NSLog(@"ERROR: %@", error);
                                                                          }
                                                                      }];
    [task resume];
    
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
