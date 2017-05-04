//
//  ZJTextViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTextViewController.h"

@interface ZJTextViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZJTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textView.text = _text;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _textView.delegate = self;
        _textView.alwaysBounceVertical = YES;
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        [self.view addSubview:_textView];
    }
    return _textView;
}

/**
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
 
 
 @property (nonatomic, assign, readwrite) id delegate;
 声明一个delegate，那么即便delegate指向的对象销毁了，delegate中依然会保存之前对象的地址
 即，delegate成为了一个野指针...
 而使用weak，则不会有上述问题，当delegate指向的对象销毁后，delegate = nil
 
 
 在Info.plist中添加NSAppTransportSecurity类型Dictionary。
 在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
 */
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
