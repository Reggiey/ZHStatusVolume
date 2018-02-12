//
//  CustomVolumeView.swift
//  ExampleSwift
//
//  Created by 卓同学 on 2018/2/12.
//  Copyright © 2018年 QM. All rights reserved.
//

import UIKit
import ZHStatusVolume

class CustomVolumeView: UIView,ZHVolumeView {

    @IBOutlet weak var progressView: UIProgressView!
    
    func setCurrentVolume(_ volume: Float) {
        progressView.progress = volume
    }
    
    func volumeUpdated(_ volume: Float) {
        progressView.setProgress(volume, animated: true)
    }

    func viewHeight() -> CGFloat {
        return 30
    }
}
