//
//  ViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"

#define URL @"http://0.0.0.0:3000/current_issue_numbers.json" // dev
//#define URL @"http://0.0.0.0:3000/current_issue_numbers.json" // prod

#define current_issue_number_key @"current_issue_number"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if (responseObject) {
            NSDictionary *responseObjectDict = (NSDictionary *)responseObject;
            if ([responseObjectDict valueForKey:current_issue_number_key]) {
                _currentIssueNumber = (NSNumber *)[responseObjectDict valueForKey:current_issue_number_key];
                NSLog(@"_currentIssueNumber: %@", _currentIssueNumber);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
