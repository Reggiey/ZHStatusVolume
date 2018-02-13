//
//  ZHStatusVolumeManager.m
//  ZHStatusVolume
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

#import "ZHStatusVolumeManager.h"
#import "ZHStatusBarVolumeView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ZHContainerViewController.h"

@interface ZHStatusVolumeManager ()

@property (nonatomic) NSInteger displayCount;

@property (nonatomic,strong,nonnull) UIColor *indicatorTintColor;
@property (nonatomic,strong,nonnull) UIColor *barBackgroundColor;
@property (nonatomic) NSTimeInterval displayTimeInterval;

@property (strong,nonatomic) UIView<ZHVolumeView> *volumeView;
@property (strong,nonatomic) MPVolumeView *systemVolumeView;

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;

@end

@implementation ZHStatusVolumeManager

@synthesize overlayWindow = _overlayWindow;


+ (ZHStatusVolumeManager *)sharedInstance {
    static dispatch_once_t once;
    static ZHStatusVolumeManager *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)register: (UIView<ZHVolumeView> *)volumeView {
    if (volumeView) {
        [self sharedInstance].volumeView = volumeView;
    }else {
        [self sharedInstance].volumeView = [ZHStatusBarVolumeView new];
    }
    [self sharedInstance].displayTimeInterval = 1.0;
    [self sharedInstance].indicatorTintColor = [UIColor blackColor];
    [self sharedInstance].barBackgroundColor = [UIColor whiteColor];
}

+ (void)addCustomVolumeView {
    [self setupUI];
    [self sharedInstance].systemVolumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 1, 1)];
    [[self sharedInstance].overlayWindow addSubview:[self sharedInstance].systemVolumeView];
    [self sharedInstance].overlayWindow.hidden = false;
    [[AVAudioSession sharedInstance] setActive:true error:nil];
    [[NSNotificationCenter defaultCenter] addObserver:[self sharedInstance] selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

+ (void)setupUI {
    if ([self.volumeView isKindOfClass:[ZHStatusBarVolumeView class]]) {
        ZHStatusBarVolumeView *statusVolumeView = (ZHStatusBarVolumeView *)self.volumeView;
        statusVolumeView.backgroundColor = self.barBackgroundColor;
        statusVolumeView.progressView.tintColor = self.indicatorTintColor;
    }
}

+ (void)removeVolumeView {
    [[self sharedInstance].systemVolumeView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:[self sharedInstance]];
    [self sharedInstance].overlayWindow.hidden = true;
}

- (void)volumeChanged: (NSNotification *)notification {
    [[AVAudioSession sharedInstance] setActive:true error:nil];
    if([[notification.userInfo objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"] isEqualToString:@"ExplicitVolumeChange"]) {
        float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
        [self displayVolumeChanged:[AVAudioSession sharedInstance].outputVolume to:volume];
    }
}

- (void)displayVolumeChanged:(float)from to:(float)to {
    NSTimeInterval appearTimeInterval = 0.2;
    if (self.displayCount > 0) {
        self.displayCount += 1;
    }else {
        _volumeView.frame = CGRectMake(0, -(_volumeView.viewHeight), [UIScreen mainScreen].bounds.size.width, _volumeView.viewHeight);
        self.displayCount += 1;
        [self.overlayWindow.rootViewController.view addSubview:_volumeView];
        [UIView animateWithDuration:appearTimeInterval animations:^{
            _volumeView.transform = CGAffineTransformMakeTranslation(0, _volumeView.viewHeight);
        }completion:^(BOOL finished) {
            [_volumeView volumeUpdated:to];
        }];
    }
    
    [_volumeView setCurrentVolume:from];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_displayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displayCount -= 1;
        if (self.displayCount == 0) {
            [UIView animateWithDuration:appearTimeInterval animations:^{
                _volumeView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }
    });
}

#pragma mark Lazy views

- (UIWindow *)overlayWindow;
{
    if(_overlayWindow == nil) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = NO;
        _overlayWindow.windowLevel = UIWindowLevelStatusBar;
        _overlayWindow.rootViewController = [[ZHContainerViewController alloc] init];
        _overlayWindow.rootViewController.view.backgroundColor = [UIColor clearColor];
        
        // TODO: screen rotate
//        [self updateWindowTransform];
//        [self updateTopBarFrameWithStatusBarFrame:[[UIApplication sharedApplication] statusBarFrame]];
    }
    return _overlayWindow;
}

#pragma mark - class proterty

+ (NSTimeInterval)displayTimeInterval {
    return [self sharedInstance].displayTimeInterval;
}
+ (void)setDisplayTimeInterval:(NSTimeInterval)displayTimeInterval {
    [self sharedInstance].displayTimeInterval = displayTimeInterval;
}

+(UIColor *)indicatorTintColor {
    return [self sharedInstance].indicatorTintColor;
}
+(void)setIndicatorTintColor:(UIColor *)indicatorTintColor {
    [self sharedInstance].indicatorTintColor = indicatorTintColor;
}

+(UIColor *)barBackgroundColor {
    return [self sharedInstance].barBackgroundColor;
}
+(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    [self sharedInstance].barBackgroundColor = barBackgroundColor;
}

+ (UIView<ZHVolumeView> *)volumeView {
    return [self sharedInstance].volumeView;
}
@end
