//
//  ZJWebViewController.m
//  DiabetesGuard
//
//  Created by ZJ on 7/20/16.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import "ZJWebViewController.h"
#import <WebKit/WebKit.h>

@interface ZJWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ZJWebViewController

@synthesize webView = _webView;

- (instancetype)initWithAddress:(NSString *)address title:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        _address = address;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSetting];
    [self requestData];
}

- (void)initSetting {
    if (!self.title.length) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.title = infoDictionary[@"CFBundleName"]?:@"";
    }
}

- (void)stopLoad {
    [self.webView stopLoading];
}

- (void)requestData {
    if ([self.address hasPrefix:@"http:"] || [self.address hasPrefix:@"https:"]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopLoad) userInfo:nil repeats:NO];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.address] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [self.webView loadRequest:request];
    }else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.address ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    }
}

#pragma mark - UIWebViewDelegate

//当网页视图已经开始加载一个请求后，得到通知。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
}

//当网页视图结束加载一个请求之后，得到通知。
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
}

//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
- (void)webView:(UIWebView *)webView DidFailLoadWithError:(NSError*)error {
    NSLog(@"%s", __func__);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[request URL] absoluteString];                   // 获取请求的绝对路径.
    NSLog(@"requestString-->%@", requestString);
    
    return YES;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        [_webView scalesPageToFit];
        [self.view addSubview:_webView];
    }
    
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
