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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            self.currentIssueMongoId = [responseObject[0] valueForKey:CURRENT_ISSUE_MONGO_ID_KEY];
            self.currentIssueNumber = [responseObject[0] valueForKey:CURRENT_ISSUE_NUMBER_KEY];
            
            NSLog(@"self.currentIssueMongoId: %@, self.currentIssueNumber: %@", self.currentIssueMongoId, self.currentIssueNumber);
            
            if (self.currentIssueNumber) {
                [self updateCurrentIssueNumberLabel:self.currentIssueNumber];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)updateCurrentIssueNumber:(NSString *)currentIssueMongoId
{
    NSLog(@"BEFORE - updateCurrentIssueNumber() - currentIssueMongoId: %@, self.currentIssueNumber: %@", currentIssueMongoId, self.currentIssueNumber);
    
    self.currentIssueNumber = [[[NSDecimalNumber decimalNumberWithString:self.currentIssueNumber] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]] stringValue];
    
    NSLog(@"AFTER - updateCurrentIssueNumber() - currentIssueMongoId: %@, self.currentIssueNumber: %@", currentIssueMongoId, self.currentIssueNumber);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"issue" : self.currentIssueNumber};
    [manager PUT:[NSString stringWithFormat:@"http://localhost:3000/api/current_issue_number/%@", currentIssueMongoId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        [self getCurrentIssueNumber];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)updateCurrentIssueNumberLabel:(NSString *)currentIssueNumber {
    self.currentIssueNumberLabel.text = [NSString stringWithFormat:@"Current Issue Number: %@", currentIssueNumber];
}

- (IBAction)addNewCoverAction:(id)sender {
    NSLog(@"addNewCoverAction() - self.currentIssueMongoId: %@", self.currentIssueMongoId);
    [self updateCurrentIssueNumber:self.currentIssueMongoId];
}
@end
