//
//  ZHStatusBarVolumeView.m
//  ZHStatusVolume
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

#import "ZHStatusBarVolumeView.h"

@implementation ZHStatusBarVolumeView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _progressView = [UIProgressView new];
    [self addSubview:_progressView];
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftMargin = 10;
    CGFloat bottomMargin = 10;
    _progressView.frame = CGRectMake(leftMargin, self.viewHeight - bottomMargin, [UIScreen mainScreen].bounds.size.width - 2*leftMargin, 2);
}

-(void)setCurrentVolume:(float)volume {
    _progressView.tintColor = ZHStatusVolumeManager.indicatorTintColor;
    _progressView.backgroundColor = ZHStatusVolumeManager.barBackgroundColor;
    _progressView.progress = volume;
}

-(void)volumeUpdated:(float)volume {
    [_progressView setProgress:volume animated:true];
}

-(CGFloat)viewHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

@end
