//
//  EPhotoKitDemoViewController.m
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "EPhotoKitDemoViewController.h"


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
    _imageViewUsingCatagore.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark- Actions

- (IBAction)buttonPressed:(id)sender
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         //if ([group numberOfAssets] < 1) return ;
         NSLog(@"%@", group);
         
         // Within the group enumeration block, filter to enumerate just photos.
         //[group setAssetsFilter:[ALAssetsFilter allPhotos]];
         
         // Chooses the photo at the last index
//         [group enumerateAssetsWithOptions:NSEnumerationReverse
//                                usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
//          {
//              
//              // The end of the enumeration is signaled by asset == nil.
//              if (alAsset)
//              {
//                  ALAssetRepresentation *representation = [alAsset defaultRepresentation];
//                  UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
//                  
//                  // Stop the enumerations
//                  *stop = YES; *innerStop = YES;
//                  
//                  // Do something interesting with the AV asset.
//                  
//              }
//          }];
     } failureBlock: ^(NSError *error) {
         // Typically you should handle an error more gracefully than this.
         NSLog(@"No groups");
     }];
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


#pragma -mark- UIImageViewDelegate
- (void)imageView:(UIImageView *)imageView
         imageGet:(UIImage *)image
   fromSourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSLog(@"UIImageViewDelegate triggered!!");
}


@end
