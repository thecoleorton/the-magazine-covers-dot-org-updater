//
//  ViewController.h
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentIssueNumberLabel;
@property (nonatomic, retain) NSString *currentIssueMongoId;
@property (nonatomic, retain) NSString *currentIssueNumber;

- (void)updateCurrentIssueNumber:(NSString *)currentIssueMongoId toAddCover:(BOOL)addCover;

- (IBAction)addCoverAction:(id)sender;
- (IBAction)removeCoverAction:(id)sender;

@end
