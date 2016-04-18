//
//  EditImageViewController.h
//  WeatherLifer
//
//  Created by ink on 15/5/7.
//  Copyright (c) 2015年 ink. All rights reserved.
//

typedef enum {
    NORMAL_TYPE,
    HUDSON_TYPE,
    RISE_TYPE,
    X_PRO_TYPE,
    WALDEN_TYPE,
    ARARO_TYPE,
    EARLYBIRD_TYPE,
} effectType;

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "IFImageFilter.h"
#import "IFSutroFilter.h"
#import "IFRotationFilter.h"
#import "IFAmaroFilter.h"
#import "IFNormalFilter.h"
#import "IFRiseFilter.h"
#import "IFHudsonFilter.h"
#import "IFXproIIFilter.h"
#import "IFSierraFilter.h"
#import "IFLomofiFilter.h"
#import "IFEarlybirdFilter.h"
#import "IFToasterFilter.h"
#import "IFBrannanFilter.h"
#import "IFInkwellFilter.h"
#import "IFWaldenFilter.h"
#import "IFHefeFilter.h"
#import "IFValenciaFilter.h"
#import "IFNashvilleFilter.h"
#import "IF1977Filter.h"
#import "IFLordKelvinFilter.h"
#import "UIImage+IF.h"
#import "ShareView.h"
@interface EditImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,ShareButtonDelegate,UIGestureRecognizerDelegate>{
        UILabel * _authLabel;
    BOOL isShare;
    
}
- (instancetype)initWithImage:(UIImage *)image;
@property (nonatomic, strong) IFImageFilter *filter;
@property (nonatomic, strong) GPUImagePicture *sourcePicture1;
@property (nonatomic, strong) GPUImagePicture *sourcePicture2;
@property (nonatomic, strong) GPUImagePicture *sourcePicture3;
@property (nonatomic, strong) GPUImagePicture *sourcePicture4;
@property (nonatomic, strong) GPUImagePicture *sourcePicture5;

@property (nonatomic, strong) IFImageFilter *internalFilter;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture1;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture2;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture3;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture4;
@property (nonatomic, strong) GPUImagePicture *internalSourcePicture5;
@property (nonatomic, unsafe_unretained) effectType currentFilterType;
@property (nonatomic, strong) IFRotationFilter *rotationFilter;
@property (nonatomic, strong) GPUImagePicture *stillImageSource;
@property (nonatomic, assign) NSInteger degress;
@property (nonatomic, strong) UIImage * iconImage;
@property (nonatomic, copy) NSString * temperatureText;
@property (nonatomic, strong) NSMutableArray * textArray;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, assign) BOOL isWhite;
@property (nonatomic, copy) NSString * placeString;
@end
