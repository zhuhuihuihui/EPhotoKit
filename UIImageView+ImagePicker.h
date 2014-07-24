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

@interface UIImageView (ImagePicker) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) UIImagePickerController *imagePickerController;

- (void)setImagePickerEnable:(BOOL)enable;



@end
