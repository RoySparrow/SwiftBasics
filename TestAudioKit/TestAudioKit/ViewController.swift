//
//  ViewController.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/13.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AudioKit
import AVFoundation
import UIKit

// Test receive voice from microphone.

class ViewController: UIViewController {
    
    private var engine: AudioEngine!
    
    private var mic: AudioEngine.InputNode? = nil
    
    private var tracker: PitchTap? = nil
    
    private var silence: Fader? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try engine.start()
            tracker?.start()
        } catch {
            print("AudioEngine start failed. error: \(error)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        engine.stop()
    }
    
    private func setup() {
        Settings.audioInputEnabled = true
        Settings.enableLogging = true
        
        engine = AudioEngine()
        mic = engine.input
        if let mic = mic {
            tracker = PitchTap(mic, handler: { [weak self] (pitch, amp) in
                self?.pitchHandler(pitch: pitch, amp: amp)
            })
            silence = Fader(mic, gain: 0)
        }
        engine.output = silence
    }
    
    private func pitchHandler(pitch: [Float], amp: [Float]) {
        print("pitch: \(pitch)")
        print("amp: \(amp)")
    }
}

