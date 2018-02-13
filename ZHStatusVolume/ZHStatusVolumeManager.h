//
//  ZHStatusVolumeManager.h
//  ZHStatusVolume
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZHVolumeView

- (void)setCurrentVolume:(float)volume;
- (void)volumeUpdated:(float)volume;

- (CGFloat)viewHeight;

@end

@interface ZHStatusVolumeManager : NSObject

@property (class,strong,nonatomic,readonly,nullable) UIView<ZHVolumeView> *volumeView;

@property (class,nonatomic,strong,nonnull) UIColor *indicatorTintColor;
@property (class,nonatomic,strong,nonnull) UIColor *barBackgroundColor;


/**
 volume view appear duration, defalut value is 1.0
 */
@property (class,nonatomic) NSTimeInterval displayTimeInterval;

+ (void)register: (UIView<ZHVolumeView> *_Nullable)volumeView;
+ (void)addCustomVolumeView;
+ (void)removeVolumeView;

@end
