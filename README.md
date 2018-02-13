# ZHStatusVolume

[![CocoaPods](https://img.shields.io/cocoapods/v/ZHStatusVolume.svg?style=flat)](http://cocoadocs.org/docsets/ZHStatusVolume/)

Hide system volume hud, display upon status bar.Compatible with swift.

![](/resource/bar.gif)

## Usage

### 1.Setup 

#### Use default volume view:

```objective-c
[ZHStatusVolumeManager regiseter:nil];

//config volume view style
 ZHStatusVolumeManager.barBackgroundColor = [UIColor whiteColor];
 ZHStatusVolumeManager.indicatorTintColor = [UIColor darkGrayColor];
```

#### Custom volume view: 

implement a UIView conform to protocol  `ZHVolumeView` :

```objective-c
@protocol ZHVolumeView

- (void)setCurrentVolume:(float)volume;
- (void)volumeUpdated:(float)volume;

- (CGFloat)viewHeight;

@end
```
then register with custom view instance:

```swift
import ZHStatusVolume

let customeView = Bundle.main.loadNibNamed("CustomVolumeView", owner: nil, options: nil)?.first as! CustomVolumeView
ZHStatusVolumeManager.regiseter(customeView)
```

### 2.Start it

```objective-c
// volume changed view will only display upon status bar
[ZHStatusVolumeManager addCustomVolumeView];

```

### 3.Stop

If you only need some pages hide system volume hud, you could call this method to back to standard way.

```objective-c
// back to standard way
[ZHStatusVolumeManager removeVolumeView];

```
## Installation

### CocoaPods:

`pod 'ZHStatusVolume'`

## Beware

Get volume by using `AVAudioSession`, so during status volume work, codebase will set `AVAudioSession ` active.

## Todo

Support rotating screen.

## 微博

[@没故事的卓同学](https://weibo.com/1926303682)

## Thanks

[JDStatusBarNotification](https://github.com/calimarkus/JDStatusBarNotification)