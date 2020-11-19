//
//  ViewController.swift
//  RealLight
//
//  Created by Никита Акиндинов on 19.11.2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var isLightOn = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.titleLabel?.text = "Включить"
    }

    fileprivate func updateUI () {
        isLightOn ? button.setTitle("Выключить", for: .normal) : button.setTitle("Включить", for: .normal)
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                try device.setTorchModeOn(level: 1.0)
            }
        } catch {
            return
        }
        
        device.unlockForConfiguration()
    }
    
    @IBAction func buttonPressed() {
        isLightOn.toggle()
        updateUI()
    }
    
}

