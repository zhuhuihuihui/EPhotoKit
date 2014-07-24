//
//  UIView+FindUIViewController.h
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-24.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)

- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;

@end
