//
//  ZHStatusBarVolumeView.h
//  ZHStatusVolume
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatusVolumeManager.h"

@interface ZHStatusBarVolumeView : UIView<ZHVolumeView>

@property (nonatomic,strong) UIProgressView *progressView;

@end
