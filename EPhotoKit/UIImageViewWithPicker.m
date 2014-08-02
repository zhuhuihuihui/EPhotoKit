//
//  UIImageViewWithPicker.m
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-8-2.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "UIImageViewWithPicker.h"

@implementation UIImageViewWithPicker

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDelegate:(id<UIImageViewWithPickerDelegate>)delegate
{
    if (_delegate != delegate)
    {
        _delegate = delegate;
        NSAssert([_delegate respondsToSelector:@selector(imageViewWithPicker:imageGet:fromSourceType:)], @"Some delegates are not implemented");
    }
}

- (void)setImagePickerEnable:(BOOL)enable
{
    if (enable)
    {
        [self setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
        
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    else
    {
        [self setUserInteractionEnabled:NO];
    }
    
    
}

- (void) imageViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Cate"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Photo", @"Camera", @"Lastest Token",nil];
    
    [actionSheet showInView:self];
}
#pragma -mark- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld", (long)buttonIndex);
    switch (buttonIndex)
    {
        case Photo:
        {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        case Camera:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"camera not support");
                return;
            }
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case LatestTaken:
        {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
            [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                   usingBlock:^(ALAssetsGroup *group, BOOL *stop)
             {
                 if ([group numberOfAssets] < 1) return ;
                 // Within the group enumeration block, filter to enumerate just photos.
                 [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                 
                 // Chooses the photo at the last index
                 [group enumerateAssetsWithOptions:NSEnumerationReverse
                                        usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
                  {
                      
                      // The end of the enumeration is signaled by asset == nil.
                      if (alAsset)
                      {
                          ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                          UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
                          
                          // Stop the enumerations
                          *stop = YES; *innerStop = YES;
                          
                          // Do something interesting with the AV asset.
                          [self setImage:latestPhoto];
                          
                          if (_delegate)
                          {
                              [_delegate imageViewWithPicker:self
                                                    imageGet:latestPhoto
                                              fromSourceType:LatestTaken];
                          }
                      }
                  }];
             } failureBlock: ^(NSError *error) {
                 // Typically you should handle an error more gracefully than this.
                 NSLog(@"No groups");
             }];
        }
            break;
            
        default:
            break;
    }
}

#pragma -mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString: (NSString *)kUTTypeImage])
    {
        [self setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }
    else if([mediaType isEqualToString: (NSString *)kUTTypeMovie])
    {
        
    }
    
    if (_delegate)
    {
        NSString *metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
        [_delegate imageViewWithPicker:self
                              imageGet:self.image
                        fromSourceType: (metadata ? Camera: Photo)];
    }
    
    [[self firstAvailableUIViewController] dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[self firstAvailableUIViewController] dismissViewControllerAnimated:YES completion:NULL];
}

#pragma -mark- Custom Methods
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.isAnimating)
    {
        [self stopAnimating];
    }
    
    
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    //imagePickerController.allowsEditing = YES;
    /** To control if it supports videos*/
    //imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    NSLog(@"%@", [UIImagePickerController availableMediaTypesForSourceType:sourceType]);
    
    /** Uncomment this to make a customized view, when taking a photo*/
    //    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    //    {
    //        /*
    //         The user wants to use the camera interface. Set up our custom overlay view for the camera.
    //         */
    //        imagePickerController.showsCameraControls = NO;
    //
    //        /*
    //         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
    //         */
    //        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
    //        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
    //        imagePickerController.cameraOverlayView = self.overlayView;
    //        self.overlayView = nil;
    //    }
    
    //self.imagePickerController = imagePickerController;
    [[self firstAvailableUIViewController] presentViewController:imagePickerController animated:YES completion:nil];
}




@end
