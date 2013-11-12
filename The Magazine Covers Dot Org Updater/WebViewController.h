//
//  WebViewController.h
//  The Magazine Covers Dot Org Updater
//
//  Created by Cole Orton on 11/11/13.
//  Copyright (c) 2013 Cole Orton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
