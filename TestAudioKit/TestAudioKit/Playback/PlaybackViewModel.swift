//
//  PlaybackViewModel.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/20.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AudioKit
import AVFoundation
import Foundation

class PlaybackViewModel {
    
    private let audioFileName = "Spring Chicken.aac"
    
    private let engine: AudioEngine
    
    private var player: AudioPlayer
    
    private var mic: AudioEngine.InputNode
    
    private var tracker: PitchTap!
    
    private var silence: Fader
    
    private var mixer: Mixer
    
    private var hasStart = false
    
    init() {
        guard let filePath = Bundle.main.path(forResource: audioFileName, ofType: nil) else { fatalError() }
        let fileUrl = URL(fileURLWithPath: filePath)
        
        engine = AudioEngine()
        guard let input = engine.input else { fatalError() }
        guard let player = AudioPlayer(url: fileUrl) else { fatalError() }
        
        self.player = player
        mic = input
        silence = Fader(mic, gain: 0)
        
        mixer = Mixer(self.player, silence)
        engine.output = mixer
        
        tracker = PitchTap(mic, handler: { [weak self] (pitch, amp) in
            self?.pitchHandler(pitch: pitch, amp: amp)
        })
    }
    
    func start() {
        guard !hasStart else { return }
        
        Settings.audioInputEnabled = true
        
        do {
            try engine.start()
            tracker.start()
            player.play()
            hasStart = true
        } catch {
            print("AudioEngine start failed. error: \(error)")
        }
    }
    
    func stop() {
        guard hasStart else { return }
        
        player.stop()
        engine.stop()
        hasStart = false
    }
    
    func playback() {
        // TODO: - play recorded data
    }
    
    private func pitchHandler(pitch: [Float], amp: [Float]) {
        print("pitch: \(pitch), amp: \(amp)")
    }
    
    deinit {
        print("deinit.")
    }
}
