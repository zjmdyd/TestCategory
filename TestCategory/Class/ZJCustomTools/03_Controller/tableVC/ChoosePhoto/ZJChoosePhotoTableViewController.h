//
//  ZJChoosePhotoTableViewController.h
//  WeiMing
//
//  Created by Zengjian on 2018/3/13.
//  Copyright © 2018年 HY. All rights reserved.
//

#import "ZJNormalTableViewController.h"

typedef void(^ChoosePhotoCompletion)(BOOL success, NSString *path);

#ifdef ZJMMPopupView
#import <MMPopupView/MMSheetView.h>
#endif

#ifdef ZJVPImageCropper
#import "VPImageCropperViewController.h"
#endif

#ifdef ZJMWPhotoBrowser
#import "MWPhotoBrowser.h"
#endif

@interface ZJChoosePhotoTableViewController : ZJNormalTableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger currentIdx;
@property (nonatomic, assign) BOOL hasEmptyImage;   // 填充图片
@property (nonatomic, assign) BOOL selectPhotoSuccess;   // 选择图片成功
@property (nonatomic, assign) BOOL uploadPhotoSuccess;   // 选择图片成功
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) ChoosePhotoCompletion compeletion;

- (void)chooseImageIsAddNew:(BOOL)isAdd completion:(ChoosePhotoCompletion)cmpt;
- (void)showImageAtIndex:(NSInteger)index;

@end
