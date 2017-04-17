//
//  HYWebViewController.m
//  DiabetesGuard
//
//  Created by ZJ on 7/20/16.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import "HYWebViewController.h"
#import <WebKit/WebKit.h>

@interface HYWebViewController ()<UIWebViewDelegate, HYErrorViewDelegate, UIActionSheetDelegate> {
    NSString *_urlString;   // 没带用户ID的URL
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) HYErrorView *errorView;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, copy) NSString *shareText;

@end

#define LoginURL @"xahealth://OnShare"
#define ListUrl @"http://xahealth.hanyouapp.com/doctor/html/headlineNews.html" 

@implementation HYWebViewController

- (instancetype)initWithWebName:(NSString *)webName title:(NSString *)title {
    if (self = [super init]) {
        _urlString = webName;
        self.title = title;
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
        self.title = infoDictionary[@"CFBundleName"];
    }
    self.navigationItem.leftBarButtonItem = [self barButtonWithImageName:@"backImg2"];
}

- (void)setShareUrl:(NSString *)shareUrl {
    _shareUrl = shareUrl;
    
    self.navigationItem.rightBarButtonItem = [self barButtonWithImageName:@"ic_fenxiang_white_48x48"];
    self.navigationItem.rightBarButtonItem.tag = 1;
}

/**
 * 分享
 */
- (void)barItemAction:(UIBarButtonItem *)sender {
    if (sender.tag == 0) {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [HYSocialShareTools showSheetInView:self shareTitle:self.shareTitle shareText:@"健康头条" shareURL:self.shareUrl shareImage:[UIImage imageNamed:@"icon"]];
    }
}

- (void)stopLoad {
    [self.webView stopLoading];
    HiddenProgressView(YES, @"加载失败", YES);
    [self.errorView showErrorViewWithMsg:@"加载失败" type:HYErrorViewTypeOfError];
}

- (void)requestData {
    if ([_urlString hasPrefix:@"http:"] || [_urlString hasPrefix:@"https:"]) {
        self.webView.delegate = self;
        HiddenProgressView(NO, @"请稍后", NO);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopLoad) userInfo:nil repeats:NO];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            [self.timer invalidate];
            if (response && !connectionError) {
                [self.webView loadRequest:request];
            }else {
                NSString *text;
                if (!response) {
                    text = @"暂无响应";
                    HiddenProgressView(YES, text, YES);
                }else {
                    text = @"连接失败";
                    HiddenProgressView(YES, text, YES);
                }
                [self.errorView showErrorViewWithMsg:text type:HYErrorViewTypeOfError];
            }
        }];
    }else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_urlString ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    }
}

#pragma mark - HYErrorViewDelegate

- (void)errorViewDidTriggerEvent:(HYErrorView *)view {
    view.hidden = YES;
    [self requestData];
}

- (HYErrorView *)errorView {
    if (!_errorView) {
        _errorView = [[NSBundle mainBundle] loadNibNamed:@"HYErrorView" owner:nil options:nil].firstObject;
        _errorView.delegate = self;
        _errorView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        [self.view addSubview:_errorView];
    }
    return _errorView;
}

#pragma mark - UIWebViewDelegate

//当网页视图已经开始加载一个请求后，得到通知。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    HiddenProgressView(NO, @"请稍后", NO);
}

//当网页视图结束加载一个请求之后，得到通知。
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    HiddenProgressView(YES, @"加载完成", NO);
    self.errorView.hidden = YES;
}

//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
- (void)webView:(UIWebView *)webView DidFailLoadWithError:(NSError*)error {
    NSLog(@"%@", error);
    HiddenProgressView(YES, @"加载失败", YES);
    [self.errorView showErrorViewWithMsg:@"加载失败" type:HYErrorViewTypeOfError];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[request URL] absoluteString];                   // 获取请求的绝对路径.
    if ([requestString isEqualToString:LoginURL]) {
        return NO;
    }
    
    return YES;
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
