//
//  AppDelegate.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/13.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AudioKit
import AVFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupAudio()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: -
    
    private func setupAudio() {
        Settings.bufferLength = .short
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try audioSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .mixWithOthers])
            try audioSession.setActive(true, options: [])
        } catch {
            print("AudioSession setup failed. error: \(error)")
        }
    }
}

