//
//  ZJChoosePhotoTableViewController+ZJChoosePhoto.m
//  WeiMing
//
//  Created by Zengjian on 2018/3/13.
//  Copyright © 2018年 HY. All rights reserved.
//

#import "ZJChoosePhotoTableViewController+ZJChoosePhoto.h"

@implementation ZJChoosePhotoTableViewController (ZJChoosePhoto)

#pragma mark - 头像

- (void)chooseImageIsAddNew:(BOOL)isAdd completion:(ChoosePhotoCompletion)cmpt {
    self.compeletion = cmpt;
    __weak typeof(self) weakSelf = self;
    
#ifdef ZJMMPopupView
    MMPopupItemHandler block = ^(NSInteger index) {
        switch (index) {
            case 0:
                [weakSelf chooseImageFromLibary];
                break;
            case 1:
                [weakSelf chooseImageFromCamera];
                break;
            case 2:
                [weakSelf browserThePhoto];
                break;
            default:
                break;
        }
    };
    
    NSMutableArray *items =
    @[
      MMItemMake(@"相册", MMItemTypeNormal, block),
      MMItemMake(@"拍照", MMItemTypeNormal, block)
      ].mutableCopy;
    
    if (!isAdd) {
        [items addObject:MMItemMake(@"查看照片", MMItemTypeNormal, block)];
    }
    
    [[[MMSheetView alloc] initWithTitle:nil items:items] showWithBlock:nil];
#endif
}

- (void)chooseImageFromLibary {
    [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)chooseImageFromCamera {
    [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
}

- (void)pickImageWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = type;
#ifdef MainColor
    picker.navigationBar.barTintColor = [UIColor mainColor];
#endif
    picker.navigationBar.tintColor = [UIColor whiteColor];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self.navigationController presentViewController:picker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (!portraitImg) {
            ShowProgressView(@"此张照片格式不符合,请重新选择", 2.0, MBProgressHUDModeText); return;
        }
        // present the cropper view controller
#ifdef ZJVPImageCropper
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.confirmTitle = @"确定";
        imgCropperVC.cancelTitle = @"取消";
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
#endif
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - VPImageCropperDelegate

#ifdef ZJVPImageCropper

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        UIImage *scaledImage = editedImage;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        
        NSString *name = [NSDate todayTimestampString];
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", name]];   // 保存文件的名称
        NSLog(@"imagePath = %@", filePath);
        
        // 保存成功会返回YES
        BOOL result = [UIImageJPEGRepresentation(scaledImage, 1.0) writeToFile:filePath atomically:YES];
        self.selectPhotoSuccess = result;
        self.compeletion(result, filePath);
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{}];
}

#endif

#pragma mark - 图片浏览

- (void)browserThePhoto {
#ifdef ZJMWPhotoBrowser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    //设置当前要显示的图片
    [browser setCurrentPhotoIndex:self.currentIdx];
    //push到MWPhotoBrowser
    
    [self.navigationController pushViewController:browser animated:YES];
#endif
}

#ifdef ZJMWPhotoBrowser

#pragma mark - MWPhotoBrowserDelegate

//返回图片个数

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count - (self.hasEmptyImage ? 1:0);
}

//返回图片模型
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    //创建图片模型
    NSString *path = self.photos[index];
    MWPhoto *photo;
    if ([path isOnlinePic]) {
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:path]];
    }else {
        photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:path]];
    }
    
    return photo;
}

#endif

- (void)showImageAtIndex:(NSInteger)index {
    self.currentIdx = index;
    [self browserThePhoto];
}

@end
