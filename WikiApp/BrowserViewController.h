//
//  BrowserViewController.h
//  WikiApp
//
//  Created by Etay Luz on 1/13/15.
//  Copyright (c) 2015 com.desk.wikiapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton  *backButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property NSString *url;
@end
