//
//  ViewController.swift
//  TestNotificationCenter
//
//  Created by Roy Sparrow on 2021/1/11.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func presentAlertButtonTapped(_ sender: UIButton) {
        let alertVC = getAlertVC(message: "present alert.") { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.addLogToTextView("Dismiss alert.")
        }
        present(alertVC, animated: true, completion: nil)
        addLogToTextView("Present alert.")
    }
    
    @IBAction func showWindowButtonTapped(_ sender: UIButton) {
        guard let rootVC = window.rootViewController else { return }
        
        let alertVC = getAlertVC(message: "show window.") { [weak rootVC, weak self] in
            guard let rootVC = rootVC else { return }
            rootVC.dismiss(animated: true) { [weak self] in
                self?.window.isHidden = true
            }
            self?.addLogToTextView("Dimiss alert and hide another window.")
        }
        window.makeKeyAndVisible()
        rootVC.present(alertVC, animated: true, completion: nil)
        addLogToTextView("Present alert to another window.")
    }
    
    @IBAction func askPermissionButtonTapped(_ sender: UIButton) {
        requestRecordPermission()
    }
    
    private lazy var window: UIWindow = {
        addLogToTextView("Init another window.")
        if let windowScene = self.view.window?.windowScene {
            $0.frame = windowScene.coordinateSpace.bounds
            $0.windowScene = windowScene
            addLogToTextView("Set window scene.")
        } else {
            $0.frame = UIScreen.main.bounds
            addLogToTextView("No window scene.")
        }
        $0.windowLevel = .alert - 1
        $0.backgroundColor = .clear
        
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        $0.rootViewController = vc
        return $0
    }(UIWindow())
    
    // MARK: - Audio
    
    private lazy var audioSession = AVAudioSession.sharedInstance()
    
    // MARK: - Notification
    
    private lazy var notificationCenter = NotificationCenter.default
    
    private lazy var didBecomeActiveNotification = UIApplication.didBecomeActiveNotification
    
    private lazy var willResignActiveNotification = UIApplication.willResignActiveNotification
    
    private lazy var willEnterForegroundNotification = UIApplication.willEnterForegroundNotification
    
    private lazy var didEnterBackgroundNotification = UIApplication.didEnterBackgroundNotification
    
    private lazy var willTerminateNotification = UIApplication.willTerminateNotification
    
    private lazy var selectorFunc = #selector(receiveNotification(notification:))
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterNotification()
    }
    
    // MARK: -
    
    private func registerNotification() {
        notificationCenter.addObserver(self, selector: selectorFunc, name: didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: selectorFunc, name: willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: selectorFunc, name: willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: selectorFunc, name: didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: selectorFunc, name: willTerminateNotification, object: nil)
        addLogToTextView("Notification registered.")
    }
    
    private func unregisterNotification() {
        notificationCenter.removeObserver(self)
        addLogToTextView("Notification unregistered.")
    }
    
    @objc
    private func receiveNotification(notification: Notification) {
        switch notification.name {
        case didBecomeActiveNotification:
            addLogToTextView("Receive didBecomeActiveNotification.")
        case willResignActiveNotification:
            addLogToTextView("Receive willResignActiveNotification.")
        case willEnterForegroundNotification:
            addLogToTextView("Receive willEnterForegroundNotification.")
        case didEnterBackgroundNotification:
            addLogToTextView("Receive didEnterBackgroundNotification.")
        case willTerminateNotification:
            addLogToTextView("Receive willTerminateNotification.")
        default:
            addLogToTextView("Receive other notification: \(notification.name).")
        }
    }
    
    private func addLogToTextView(_ log: String) {
        var newText = textView.text ?? ""
        newText += "\(log)\n----------\n"
        textView.text = newText
        
        let bottomRange = NSMakeRange(newText.count - 1, 1)
        textView.scrollRangeToVisible(bottomRange)
    }
    
    private func getAlertVC(message: String, okButtonTapped: (()->Void)?) -> UIAlertController {
        let alertVC = UIAlertController(title: "Tip", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            okButtonTapped?()
        }
        alertVC.addAction(alertAction)
        return alertVC
    }
    
    private func requestRecordPermission() {
        switch audioSession.recordPermission {
        case .denied:
            addLogToTextView("Record permission is denied.")
        case .granted:
            addLogToTextView("Record permission is granted.")
        case .undetermined:
            addLogToTextView("Record permission is undetermined.")
            audioSession.requestRecordPermission { [weak self] (granted) in
                DispatchQueue.main.async { [weak self] in
                    self?.addLogToTextView(granted ? "User grant." : "User deny.")
                }
            }
        @unknown default:
            addLogToTextView("Record permission status: \(audioSession.recordPermission).")
        }
    }
}

