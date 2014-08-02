//
//  EPhotoKitDemoViewController.h
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+ImagePicker.h"

@interface EPhotoKitDemoViewController : UIViewController <UIActionSheetDelegate, UIImageViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUsingCatagore;


@end
