//
//  ViewController.h
//  HTMLTestApp
//
//  Created by on 1/24/13.
//  Copyright (c) 2013 La. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *mywebview;

@end
