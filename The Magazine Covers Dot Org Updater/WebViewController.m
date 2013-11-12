//
//  WebViewController.m
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 11/11/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(dismissModalView)];
    
    [self loadTheMagazineCoversDorOrg];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTheMagazineCoversDorOrg
{
    NSString *urlAddress = @"http://the-magazine-covers.org";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}

- (void)dismissModalView
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
