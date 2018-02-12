# ZHStatusVolume

Hide system volume hud, display upon status bar.

![](/resource/bar.gif)

## Usage

###1.Setup 

#### Use default volume view:

```objective-c
[ZHStatusVolumeManager regiseter:nil];

//config volume style
 ZHStatusVolumeManager.barBackgroundColor = [UIColor whiteColor];
 ZHStatusVolumeManager.indicatorTintColor = [UIColor darkGrayColor];
```

####Custom volume view: 

implement a UIView conform to protocol  `ZHVolumeView` :

```objective-c
@protocol ZHVolumeView

- (void)setCurrentVolume:(float)volume;
- (void)volumeUpdated:(float)volume;

- (CGFloat)viewHeight;

@end
```
Then register with custom view instance:

```swift
import ZHStatusVolume

	let customeView = Bundle.main.loadNibNamed("CustomVolumeView", owner: nil, options: nil)?.first as! CustomVolumeView
	ZHStatusVolumeManager.regiseter(customeView)
```

### 2.Start working

```objective-c
// volume changed view will only display upon status bar
[ZHStatusVolumeManager addCustomVolumeView];

// back to stand way
[ZHStatusVolumeManager removeVolumeView];

```

