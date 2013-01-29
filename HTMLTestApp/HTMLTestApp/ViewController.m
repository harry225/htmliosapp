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
    
    [self setTitle:@"My Data"];
    
    
//      [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.11/jqdemo/demo.html"]]];
    
////    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.11/htmliosapp/table.html"]]];
//
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *secondParentPath = [[bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
    
    NSLog(@"path %@",secondParentPath);
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
    
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
            
            
            NSLog(@"Done  %@",[[request URL] absoluteString]);
            
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
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"jquery.mobile-1.2.0.min"
//                                                        ofType:@"css"];
//    NSString *js = @"document.getElementsByTagName('link').setAttribute('href','";
//    NSString *js2 = [js stringByAppendingString:cssPath];
//    NSString *finalJS = [js2 stringByAppendingString:@"');"];
//    
//    //check element structure
//    NSString *res = [webView stringByEvaluatingJavaScriptFromString:finalJS];
    
    
    
}
- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (alertView.tag==1) {
        NSLog(@"alert cancel pressed");
    }
}
@end
