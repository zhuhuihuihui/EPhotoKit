//
//  EPhotoKitDemoViewController.m
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "EPhotoKitDemoViewController.h"
#import "UIImageView+ImagePicker.h"

@interface EPhotoKitDemoViewController ()

@end

@implementation EPhotoKitDemoViewController
@synthesize imageView = _imageView;
@synthesize imageViewUsingCatagore = _imageViewUsingCatagore;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    
    [_imageView addGestureRecognizer:tapGestureRecognizer];
    
    [_imageViewUsingCatagore setImagePickerEnable:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    
}

- (void) imageViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Photo", @"Camera", @"Lastest Token",nil];
    
    [actionSheet showInView:self.view];
}

#pragma -mark- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
    switch (buttonIndex)
    {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}



@end
