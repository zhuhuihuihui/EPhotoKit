//
//  UIImageView+ImagePicker.m
//  EPhotoKitDemo
//
//  Created by Scott Zhu on 14-7-23.
//  Copyright (c) 2014年 Scott Zhu. All rights reserved.
//

#import "UIImageView+ImagePicker.h"
//@interface UIImageView()
//@property (nonatomic) UIImagePickerController *imagePickerController;
//@end

@implementation UIImageView (ImagePicker)


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
    NSLog(@"%d", buttonIndex);
    switch (buttonIndex)
    {
        case 0:
        {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        case 1:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"camera not support");
                return;
            }
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
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
    //imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    NSLog(@"%@", [UIImagePickerController availableMediaTypesForSourceType:sourceType]);
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = NO;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
//        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
//        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
//        imagePickerController.cameraOverlayView = self.overlayView;
//        self.overlayView = nil;
    }
    
    //self.imagePickerController = imagePickerController;
    [[self firstAvailableUIViewController] presentViewController:imagePickerController animated:YES completion:nil];
}



@end
