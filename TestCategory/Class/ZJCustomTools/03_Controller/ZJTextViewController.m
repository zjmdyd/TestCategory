//
//  ZJTextViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTextViewController.h"

@interface ZJTextViewController ()<UITextViewDelegate> {
    NSString *_originText;
}

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZJTextViewController

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        
        _originText = self.text;
    }
    
    return self;
}

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
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (![_originText isEqualToString:self.textView.text]) {
        if ([self.delegate respondsToSelector:@selector(textViewController:didEndEditText:)]) {
            [self.delegate textViewController:self didEndEditText:self.textView.text];
        }
    }
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
