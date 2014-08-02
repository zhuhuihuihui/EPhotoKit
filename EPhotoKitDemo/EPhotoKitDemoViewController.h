//
//  EPhotoKitDemoViewController.h
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+ImagePicker.h"
#import "UIImageViewWithPicker.h"

@interface EPhotoKitDemoViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UIImageViewWithPickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageViewWithPicker *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUsingCatagore;


@end
