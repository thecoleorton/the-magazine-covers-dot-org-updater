//
//  ViewController.h
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 10/31/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) PFQuery *query;
@property (nonatomic, retain) NSString *currentIssueMongoId;
@property (nonatomic, retain) NSNumber *currentIssueNumber;
@property (weak, nonatomic) IBOutlet UILabel *currentIssueNumberLabel;

- (void)updateCurrentIssueNumber:(NSString *)currentIssueMongoId toAddCover:(BOOL)addCover;

- (IBAction)addCoverAction:(id)sender;
- (IBAction)removeCoverAction:(id)sender;

@end
