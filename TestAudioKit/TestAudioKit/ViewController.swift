//
//  ViewController.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/13.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AudioKit
import UIKit

class ViewController: UIViewController {

    private lazy var mic = AKMicrophone()
    
    private lazy var tracker = AKFrequencyTracker(mic)
    
    private lazy var silence = AKBooster(tracker, gain: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad.")
        setup()
    }

    private func setup() {
        AKSettings.audioInputEnabled = true
        AKSettings.defaultToSpeaker = true
        AKSettings.disableAudioSessionDeactivationOnStop = true
        AKSettings.useBluetooth = true
        AKManager.output = silence
        
        do {
            try AKManager.start()
        } catch {
            print("Start AudioKit failed. error: \(error)")
        }
    }
}

