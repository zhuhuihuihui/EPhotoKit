//
//  UIImageView+ImagePicker.h
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FindUIViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define PHOTO           0
#define CAMERA          1
#define LATEST_TAKE     2


@interface UIImageView (ImagePicker) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>



- (void)setImagePickerEnable:(BOOL)enable;


@end
