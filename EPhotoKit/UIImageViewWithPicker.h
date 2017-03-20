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

typedef NS_ENUM(NSUInteger, EPhotoSourceType) {
    EPhotoSourcePhoto,
    EPhotoSourceCamera,
    EPhotoSourceLatestTaken,
    EPhotoSourceTitle,
    EPhotoSourceCancel
};

@class UIImageViewWithPicker;

@protocol UIImageViewWithPickerDelegate <NSObject>

@optional
- (void)imageViewWithPicker:(UIImageViewWithPicker *)imageViewWithPicker
                   imageGet:(UIImage *)image
             fromSourceType:(EPhotoSourceType) sourceType;

@end


@interface UIImageViewWithPicker : UIImageView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBInspectable UIImage *placeholderImage;
@property (assign, nonatomic) IBInspectable UIEdgeInsets placeholderImageInsets;
@property (strong, nonatomic) IBInspectable NSDictionary *supportedTitles;
@property (assign, nonatomic) IBInspectable BOOL imagePickerEnable;

@property (weak, nonatomic) id <UIImageViewWithPickerDelegate> delegate;

@end
