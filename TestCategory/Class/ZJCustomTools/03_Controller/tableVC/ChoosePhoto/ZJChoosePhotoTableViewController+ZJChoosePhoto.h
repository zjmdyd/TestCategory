//
//  ZJChoosePhotoTableViewController+ZJChoosePhoto.h
//  WeiMing
//
//  Created by Zengjian on 2018/3/13.
//  Copyright © 2018年 HY. All rights reserved.
//

#import "ZJChoosePhotoTableViewController.h"

#ifdef ZJMMPopupView
#import <MMPopupView/MMSheetView.h>
#endif

#ifdef ZJVPImageCropper
#import "VPImageCropperViewController.h"
#endif

#ifdef ZJMWPhotoBrowser
#import "MWPhotoBrowser.h"
#endif

@interface ZJChoosePhotoTableViewController (ZJChoosePhoto)
#if (defined ZJMMPopupView) && (defined ZJVPImageCropper) && (defined ZJMWPhotoBrowser)
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate, MWPhotoBrowserDelegate>
#endif

- (void)chooseImageIsAddNew:(BOOL)isAdd completion:(ChoosePhotoCompletion)cmpt;
- (void)showImageAtIndex:(NSInteger)index;

@end
