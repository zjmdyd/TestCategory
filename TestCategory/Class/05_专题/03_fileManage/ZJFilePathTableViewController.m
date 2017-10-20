//
//  ZJFilePathTableViewController.m
//  ZJFoundation
//
//  Created by ZJ on 9/19/16.
//  Copyright © 2016 YunTu. All rights reserved.
//

#import "ZJFilePathTableViewController.h"
#import "ZJFilePathTableViewCell.h"
#import "UIViewExt.h"

@interface ZJFilePathTableViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_sectionTitles;
    NSMutableArray *_images;
}

@end

static NSString *ImgCellID = @"imgCell";

@implementation ZJFilePathTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
#pragma mark - 相对路径
    
    //此方法用到的是图片的相对路径
    UIImage *img1 = [UIImage imageNamed:@"1.png"];
    [_images addObject:img1];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
#pragma mark - homeDirectory
    
    NSString *path = NSHomeDirectory();                         // 获取沙箱所在文件夹的路径, 真机上面只能用此目录         // application
    NSArray *path0 = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"沙箱所在文件夹的路径:%@", path);
    NSLog(@"path0 = %@", path0);
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"documentsPath = %@", documentsPath);
    
    NSArray *path1 = [fileManager contentsOfDirectoryAtPath:documentsPath error:nil];
    NSLog(@"path1 = %@", path1);
    
    NSData *data = UIImagePNGRepresentation(img1);              // image --> data
    NSError *error;
    [data writeToFile:[documentsPath stringByAppendingPathComponent:@"new.png"] options:NSDataWritingAtomic error:&error];
    if (error) {
        NSLog(@"写入失败error:%@", error);
    }else {
        NSLog(@"写入成功");
        UIImage *img2 = [UIImage imageWithData:[NSData dataWithContentsOfFile:[documentsPath stringByAppendingPathComponent:@"new.png"]]];
        [_images addObject:img2];
    }
    
    NSLog(@"\n\n***********************************\n\n");
    
    
#pragma mark - bundlePath
    
    //获取文件的完整路径
    
    NSString *appPath = [[NSBundle mainBundle] resourcePath];  //   获取.app所在的完整路径                           // bundle
    NSLog(@".app所在的完整路径:%@", appPath);
    
    NSArray *path2 = [fileManager contentsOfDirectoryAtPath:appPath error:nil];
    NSLog(@"path2 = %@", path2);
    
    /*
     此方法用到的是图片的绝对路径
     图片有没有被文件夹所包含不影响
     */
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
    UIImage *img3 = [UIImage imageWithContentsOfFile:bundlePath];
    [_images addObject:img3];
    NSLog(@"bundlePath = %@", bundlePath);
    
    //    [self.tableView reloadData];
}

- (void)initAry {
    _sectionTitles = @[@"相对路径:imageNane", @"homeDirectory", @"bundlePath"];
    _images = [NSMutableArray array];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _images.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJFilePathTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ImgCellID];
    if (!cell) {
        cell = [[ZJFilePathTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImgCellID];
    }
    
    cell.image = _images[indexPath.section];
    if (indexPath.section == 0) {
        cell.ivContentMode = UIViewContentModeScaleToFill;
    }else if (indexPath.section == 1) {
        cell.ivContentMode = UIViewContentModeScaleAspectFit;
    }else if (indexPath.section == 2) {
        cell.ivContentMode = UIViewContentModeScaleAspectFill;
    }
    cell.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.view.height - self.navigationController.navigationBar.bottom) / 3;
}
/*
 模拟器:
 ~ <=>	/Users/yuntu/Library/Developer/CoreSimulator/Devices/51CE3F55-3758-4158-B5F1-3B5019E552DC
 NSHomeDirectory() : 沙箱所在文件夹的路径:												 ~/data/Containers/Data/Application/4EBF9A25-6BEB-4724-BFC4-6849FE71D796
 NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] 	 ~/data/Containers/Data/Application/4EBF9A25-6BEB-4724-BFC4-6849FE71D796/Documents
 
 [[NSBundle mainBundle] resourcePath] .app所在的完整路径: 								 ~/data/Containers/Bundle/Application/551B7FFD-DD10-4115-BAA1-BCD823FBC843/ZJFoundation.app
 [[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"] 							 ~/data/Containers/Bundle/Application/551B7FFD-DD10-4115-BAA1-BCD823FBC843/ZJFoundation.app/2.png
 
 // 真机
 ~ <=>	/var
 NSHomeDirectory() : 沙箱所在文件夹的路径:				 								~/mobile/Containers/Data/Application/9F14A384-BBF6-4FC5-8C55-DBCEF9C249CE
 NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]  ~/mobile/Containers/Data/Application/9F14A384-BBF6-4FC5-8C55-DBCEF9C249CE/Documents
 
 ~ <=>	/private/var
 [[NSBundle mainBundle] resourcePath] .app所在的完整路径:								~/mobile/Containers/Bundle/Application/BB99E795-75D1-4C73-B87D-22483B5B66B2/ZJFoundation.app
 [[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"] 							~/mobile/Containers/Bundle/Application/BB99E795-75D1-4C73-B87D-22483B5B66B2/ZJFoundation.app/2.png
 */
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
