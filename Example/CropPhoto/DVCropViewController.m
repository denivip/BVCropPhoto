//
//  DVCropViewController.m
//  Router
//
//  Created by Sergey Shpygar on 11.07.14.
//  Copyright (c) 2014 DENIVIP Group. All rights reserved.
//

#import "DVCropViewController.h"
#import "DVGCropView.h"

@interface DVCropViewController ()

@property (nonatomic, weak) BVCropPhotoView *cropPhotoView;

@end

@implementation DVCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cropAction:)];
}

- (void)setSourceImage:(UIImage *)sourceImage
{
    _sourceImage = sourceImage;
    [self loadCropPhotoView];
}

- (void)cropAction:(id)cropAction {
    [self.delegate cropViewControllerDidCrop:self croppedImage:self.cropPhotoView.croppedImage];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.cropPhotoView.frame = self.view.bounds;
}

- (void)_loadCropPhotoView
{
    DVGCropView *cropView = [[DVGCropView alloc] init];
    cropView.sourceImage = self.sourceImage;
    cropView.cropSize = self.cropSize;
    cropView.backgroundColor = [UIColor blackColor];
    cropView.frame = self.view.bounds;
    [self.view addSubview:cropView];
    self.cropPhotoView = cropView;
}

- (void)loadCropPhotoView
{
    if (self.cropPhotoView) {
        [self.view layoutIfNeeded];
        [UIView transitionWithView:self.view duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.cropPhotoView removeFromSuperview];
            [self _loadCropPhotoView];
        } completion:nil];
    }
    else {
        [self _loadCropPhotoView];
    }
}

@end
