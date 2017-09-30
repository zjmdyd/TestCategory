//
//  ZJAVAudioPlayerViewController.m
//  ZJFoundation
//
//  Created by ZJ on 9/19/16.
//  Copyright © 2016 YunTu. All rights reserved.
//

#import "ZJAVAudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZJAVAudioPlayerViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ZJAVAudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
//    NSURL *url = [NSURL URLWithString:@"http://wl.baidu190.com/1474860041/20170927eb7c42da5df7f1320f0bafc0803a5d.mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (IBAction)play:(UIButton *)sender {
    if (self.player.isPlaying) {
        [self.player pause];
    }else {
        [self.player play];
    }
    NSArray *titles = @[@"play", @"pause"];
    [sender setTitle:titles[self.player.isPlaying] forState:UIControlStateNormal];
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"finish  : %zd", flag);
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
