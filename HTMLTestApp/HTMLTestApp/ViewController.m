//
//  ViewController.m
//  HTMLTestApp
//
//  Created by on 1/24/13.
//  Copyright (c) 2013 La. All rights reserved.
//

#import "ViewController.h"

#import "NextViewController.h"

@interface UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame;

@end
//
//@implementation UIWebView (JavaScriptAlert)
//
//- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
//    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:@"My Alert Title" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
//    [dialogue setTag:1];
//    
//    [dialogue show];
//  
//}
//
//@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.odesk.com/jobs/rss?q=mobile"]]];
    
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *secondParentPath = [[bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
    
    NSLog(@"path %@",secondParentPath);
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" ];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [self.mywebview loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@"myinfo"]];

    [self.mywebview setDelegate:self];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // only do something if a link has been clicked...
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        // check if the url requests starts with our custom protocol:
        if ([[[request URL] absoluteString] hasSuffix:@"NextViewController"]) {
            // Do custom code
            
            
            NSLog(@"Done");
            
            NextViewController *nvc=[[NextViewController alloc]init];
            [self.navigationController pushViewController:nvc animated:YES];
            return NO;
        }
    }
    
    return YES;
}
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame {
    UIAlertView *dialogue = [[UIAlertView alloc] initWithTitle:@"My Alert Title" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    dialogue.tag = 1;
    [dialogue show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
          NSLog(@"alert ok pressed");
    }
    
    

}
- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (alertView.tag==1) {
        NSLog(@"alert cancel pressed");
    }
}
@end
