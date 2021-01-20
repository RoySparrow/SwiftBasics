//
//  LaunchViewController.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/13.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import AudioKit
import AVFoundation
import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        enterNextPage()
    }
    
    private func enterNextPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let sb = UIStoryboard(name: "PlaybackStoryboard", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "PlaybackViewController")
            self?.view.window?.rootViewController = vc
        }
    }
    
    deinit {
        print("deinit.")
    }
}

