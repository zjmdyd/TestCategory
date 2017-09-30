//
//  ZJAudioToolboxTableViewController.m
//  ZJFoundation
//
//  Created by ZJ on 9/18/16.
//  Copyright © 2016 YunTu. All rights reserved.
//

#import "ZJAudioToolboxTableViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ZJNSObjectCategory.h"

@interface ZJAudioToolboxTableViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_files, *_sectionTitles, *_cellTitles;
}

@end

NSString *TitleCell = @"cell";
NSString *kAudioPath = @"/System/Library/Audio/UISounds/";

@implementation ZJAudioToolboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    _files =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:kAudioPath error:nil];
    _cellTitles = @[
                    @[@"Vibrate"],
                    @[@"alert_message"],
                    _files
                    ];
}

- (void)initSettiing {
    _sectionTitles = @[@"振动", @"用户音频", @"系统音频"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _files.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TitleCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TitleCell];
    }

    cell.textLabel.text = _cellTitles[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitles[section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {           // 振动
        [UIApplication playSystemVibrate];
    }else if (indexPath.section == 1) {     // 用户音频
        [UIApplication playSoundWithSrcName:@"alert_message" type:@"wav"];
    }else {                                 // 系统音频
        [UIApplication playSystemSoundWithName:_files[indexPath.row]];
    }
}
//
//- (void)playSystemVibrate {
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);    // 系统声音设置里面的振动要开启才起作用
//}
//
//- (void)playSoundWithResourceName:(NSString *)resourceName type:(NSString *)type {
//    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
//    if (path) {
//        [self playWithUrl:[NSURL fileURLWithPath:path]];
//    }
//}
//
//- (void)playSystemSoundWithName:(NSString *)name {
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kAudioPath, name]];
//    [self playWithUrl:url];
//}
//
//- (void)playWithUrl:(NSURL *)url {
//    if (url) {
//        SystemSoundID soundID;
//        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
//        if (error == kAudioServicesNoError) {
//            AudioServicesPlayAlertSound(soundID);
//        }else {
//            NSLog(@"Failed to create sound");
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
