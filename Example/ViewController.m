//
//  ViewController.m
//  Example
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

#import "ViewController.h"
#import "ZHStatusVolumeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ZHStatusVolumeManager register:nil];
    [ZHStatusVolumeManager addCustomVolumeView];
    self.view.backgroundColor = [UIColor lightGrayColor];
}


@end
