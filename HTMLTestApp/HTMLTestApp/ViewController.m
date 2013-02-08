//
//  ViewController.m
//  HTMLTestApp
//
//  Created by on 1/24/13.
//  Copyright (c) 2013 La. All rights reserved.
//

#import "ViewController.h"

#import "NextViewController.h"

#import "SSZipArchive.h"

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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *zipPath=[[NSBundle mainBundle] pathForResource:@"jqdemo" ofType:@"zip"];
    
    [SSZipArchive unzipFileAtPath:zipPath toDestination:documentsDirectory];
    
    NSLog(@"Path : %@",documentsDirectory);

    
    NSString *stringURL = @"http://192.168.2.6/jqdemo/demo.html";
    
//     NSString *stringURL = @"http://192.168.2.11/htmliosapp/table.html";
    
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"index.html"];
        [urlData writeToFile:filePath atomically:YES];
    }
    
//    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.6/jqdemo/demo.html"]]];
    
////    [self.mywebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.2.11/htmliosapp/table.html"]]];
//
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
//    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
//    NSString *secondParentPath = [[bundlePath stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
    
     NSURL *baseURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingString:@"/"]];
    
    
//    NSLog(@"path %@",secondParentPath);
    
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:[@"" stringByAppendingFormat:@"/JQDemo/demo"] ofType:@"html"];
    NSError *error;
    
    NSString *htmlFile = [NSString stringWithContentsOfFile:[documentsDirectory stringByAppendingFormat:@"/index.html"] encoding:NSUTF8StringEncoding error: &error];
    
     [self.mywebview loadHTMLString:htmlFile baseURL:baseURL];
//    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
//    [self.mywebview loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@"myinfo"]];
//
    [self.mywebview setDelegate:self];
    
    
    [self.mywebview reload];
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
//    
//    NSLog(@"%@",cssPath);
//    
//     NSData *cssData = [NSData dataWithContentsOfFile:cssPath];
//    NSString* css = [[NSString alloc] initWithData:cssData encoding:NSASCIIStringEncoding];
//    
//     NSLog(@"css ---> %@",css);
//    NSString* js = [NSString stringWithFormat:
//                    @"var styleNode = document.createElement('style');\n"
//                    "styleNode.type = \"text/css\";\n"
//                    "var styleText = document.createTextNode(%@);\n"
//                    "styleNode.appendChild(styleText);\n"
//                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
//    NSLog(@"js:\n%@",js);
//    [webView stringByEvaluatingJavaScriptFromString:js];
    
    
    
}
- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (alertView.tag==1) {
        NSLog(@"alert cancel pressed");
    }
}
@end
