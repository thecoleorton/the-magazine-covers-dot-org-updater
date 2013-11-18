//
//  ViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#define PF_CLASS_NAME @"Issue"
#define CURRENT_ISSUE_OBJECT_KEY @"SX1LtTFPZ2"
#define CURRENT_ISSUE_NUMBER_KEY @"current_number"

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
    _query = [PFQuery queryWithClassName:PF_CLASS_NAME];
    [_query getObjectInBackgroundWithId:CURRENT_ISSUE_OBJECT_KEY block:^(PFObject *issue, NSError *error) {
        NSLog(@"issue: %@", issue);
        
        if (issue) {
            if ([issue valueForKey:CURRENT_ISSUE_NUMBER_KEY]) {
                _currentIssueNumber = [issue valueForKey:CURRENT_ISSUE_NUMBER_KEY];
                NSLog(@"_currentIssueNumber: %@", _currentIssueNumber);
                [self updateCurrentIssueNumberLabel:self.currentIssueNumber];
            }
        }
        
    }];
    
}

- (void)updateCurrentIssueNumber:(NSString *)currentIssueMongoId toAddCover:(BOOL)addCover
{
    
    NSLog(@"BEFORE - updateCurrentIssueNumber() - currentIssueMongoId: %@, self.currentIssueNumber: %@", currentIssueMongoId, self.currentIssueNumber);
    
    if (addCover == YES) {
        self.currentIssueNumber = [[NSDecimalNumber decimalNumberWithString:[self.currentIssueNumber stringValue]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"1"]];
    } else {
        self.currentIssueNumber = [[NSDecimalNumber decimalNumberWithString:[self.currentIssueNumber stringValue]] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"1"]];
    }
    
    NSLog(@"AFTER - updateCurrentIssueNumber() - currentIssueMongoId: %@, self.currentIssueNumber: %@", currentIssueMongoId, self.currentIssueNumber);
    
    // Retrieve the object by id
    [_query getObjectInBackgroundWithId:CURRENT_ISSUE_OBJECT_KEY block:^(PFObject *issue, NSError *error) {
        
        if (!error) {
            // Now let's update it with some new data. In this case, only cheatMode and score
            // will get sent to the cloud. playerName hasn't changed.
            issue[CURRENT_ISSUE_NUMBER_KEY] = _currentIssueNumber;
            [issue saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [self getCurrentIssueNumber];
                } else {
                    NSLog(@"Error: %@", error);
                }
            }];
            
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)updateCurrentIssueNumberLabel:(NSNumber *)currentIssueNumber
{
    self.currentIssueNumberLabel.text = [NSString stringWithFormat:@"Current Issue Number: %@", currentIssueNumber];
}

- (IBAction)addCoverAction:(id)sender
{
    NSLog(@"addCoverAction() - self.currentIssueMongoId: %@", self.currentIssueMongoId);
    [self updateCurrentIssueNumber:self.currentIssueMongoId toAddCover:YES];
}

- (IBAction)removeCoverAction:(id)sender
{
    NSLog(@"removeCoverAction() - self.currentIssueMongoId: %@", self.currentIssueMongoId);
    [self updateCurrentIssueNumber:self.currentIssueMongoId toAddCover:NO];
}

@end
