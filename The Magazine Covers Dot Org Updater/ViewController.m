//
//  ViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "ViewController.h"
#import "TMCClient.h"
#import "AFNetworking.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getCurrentIssueNumber];
    
}

- (void)getCurrentIssueNumber
{
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:3000/api/current_issue_number" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject[0]);
        
        if (responseObject) {
            _currentIssueMongoId = [responseObject[0] valueForKey:@"_id"];
            _currentIssueNumber = [responseObject[0] valueForKey:@"issue"];
            
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
