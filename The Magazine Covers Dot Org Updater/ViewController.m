//
//  ViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self getCurrentIssueNumber];
    
}

- (void)getCurrentIssueNumber
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", BASE_URL, CURRENT_ISSUE_NUMBER_PATH] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject[0]);
        
        if (responseObject) {
            _currentIssueMongoId = [responseObject[0] valueForKey:CURRENT_ISSUE_MONGO_ID_KEY];
            _currentIssueNumber = [responseObject[0] valueForKey:CURRENT_ISSUE_NUMBER_KEY];
            
            if (_currentIssueNumber) {
                [self updateCurrentIssueNumberLabel:_currentIssueNumber];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)updateCurrentIssueNumberLabel:(NSNumber *)currentIssueNumber {
    self.currentIssueNumberLabel.text = [NSString stringWithFormat:@"Current Issue Number: %@", currentIssueNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
