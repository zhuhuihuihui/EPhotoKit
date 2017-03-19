//
//  UIImageViewWithPicker.m
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-8-2.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "UIImageViewWithPicker.h"

@interface UIImageViewWithPicker ()
@property (strong, nonatomic) UIImageView *placeholderImageView;
@end

@implementation UIImageViewWithPicker

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

#pragma mark - Setter and Getter

- (void)setDelegate:(id<UIImageViewWithPickerDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        NSAssert([_delegate respondsToSelector:@selector(imageViewWithPicker:imageGet:fromSourceType:)], @"Some delegates are not implemented");
    }
}

- (void)setImagePickerEnable:(BOOL)enable {
    if (enable) {
        [self setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
        
        [self addGestureRecognizer:tapGestureRecognizer];
    } else {
        [self setUserInteractionEnabled:NO];
    }
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    [self.placeholderImageView setHidden:YES];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    [self.placeholderImageView setImage:placeholderImage];
}

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_placeholderImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_placeholderImageView];
    }
    return _placeholderImageView;
}

- (void)setPlaceholderImageInsets:(UIEdgeInsets)placeholderImageInsets {
    if (placeholderImageInsets.left + placeholderImageInsets.right >= CGRectGetWidth(self.bounds) ||
        placeholderImageInsets.top + placeholderImageInsets.bottom >= CGRectGetHeight(self.bounds))
        return;
    
    CGFloat newWidth = CGRectGetWidth(self.bounds) - placeholderImageInsets.left - placeholderImageInsets.right;
    CGFloat newHeight = CGRectGetHeight(self.bounds) - placeholderImageInsets.top - placeholderImageInsets.bottom;
    [self.placeholderImageView setFrame:CGRectMake(placeholderImageInsets.left, placeholderImageInsets.top, newWidth, newHeight)];
}

#pragma mark - Actions

- (void)imageViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSString *title = _supportedTitles? _supportedTitles[@(EPhotoSourceTitle)]: nil;
    NSString *cancel = _supportedTitles? _supportedTitles[@(EPhotoSourceCancel)]: @"Cancel";
    NSString *photo = _supportedTitles? _supportedTitles[@(EPhotoSourcePhoto)]: @"Photo";
    NSString *camera = _supportedTitles? _supportedTitles[@(EPhotoSourceCamera)]: @"Camera";
    NSString *lastestToken = _supportedTitles? _supportedTitles[@(EPhotoSourceLatestTaken)]: @"Lastest Token";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancel) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancel
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action)
        {
            
        }]];
    }
    if (photo) {
        [alertController addAction:[UIAlertAction actionWithTitle:photo
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action)
        {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }]];
    }
    if (camera) {
        [alertController addAction:[UIAlertAction actionWithTitle:camera
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action)
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"camera not support");
                return;
            }
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
        }]];
    }
    if (lastestToken) {
        [alertController addAction:[UIAlertAction actionWithTitle:lastestToken
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action)
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
                                              fromSourceType:EPhotoSourceLatestTaken];
                          }
                      }
                  }];
             } failureBlock: ^(NSError *error) {
                 // Typically you should handle an error more gracefully than this.
                 NSLog(@"No groups");
             }];
        }]];
    }
    if (_delegate && [_delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)_delegate;
        [vc presentViewController:alertController animated:YES completion:nil];
    } else {
        [[self firstAvailableUIViewController] presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma -mark- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
    switch (buttonIndex)
    {
        case EPhotoSourcePhoto:
        {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        case EPhotoSourceCamera:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"camera not support");
                return;
            }
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
        }
            break;
        case EPhotoSourceLatestTaken:
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
                                              fromSourceType:EPhotoSourceLatestTaken];
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
                        fromSourceType: (metadata ? EPhotoSourceCamera: EPhotoSourcePhoto)];
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
