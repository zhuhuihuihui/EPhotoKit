//
//  UIImageViewWithPicker.h
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-8-2.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FindUIViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>


typedef enum
{
    Photo = 0,
    Camera = 1,
    LatestTaken = 2
}SourceType;


@class UIImageViewWithPicker;

@protocol UIImageViewWithPickerDelegate <NSObject>

@optional
- (void)imageViewWithPicker:(UIImageViewWithPicker *)imageViewWithPicker
                   imageGet:(UIImage *)image
             fromSourceType:(SourceType) sourceType;

@end


@interface UIImageViewWithPicker : UIImageView <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)setImagePickerEnable:(BOOL)enable;

@property (weak, nonatomic) id <UIImageViewWithPickerDelegate> delegate;

@end
