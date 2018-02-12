//
//  ViewController.swift
//  ExampleSwift
//
//  Created by 卓同学 on 2018/2/11.
//  Copyright © 2018年 QM. All rights reserved.
//

import UIKit
import ZHStatusVolume

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customeView = Bundle.main.loadNibNamed("CustomVolumeView", owner: nil, options: nil)?.first as! CustomVolumeView
        customeView.layer.cornerRadius = 10
        ZHStatusVolumeManager.regiseter(customeView)
        ZHStatusVolumeManager.addCustomVolumeView()
    }

    @IBAction func removeStatusVolume(_ sender: Any) {
        ZHStatusVolumeManager.removeVolumeView()
    }
    
}

