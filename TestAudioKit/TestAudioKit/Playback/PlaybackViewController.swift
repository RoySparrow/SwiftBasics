//
//  PlaybackViewController.swift
//  TestAudioKit
//
//  Created by Roy Sparrow on 2021/1/20.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import UIKit

class PlaybackViewController: UIViewController {

    @IBAction func startButtonTapped(_ sender: UIButton) {
        viewModel.start()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        viewModel.stop()
    }
    
    @IBAction func playbackButtonTapped(_ sender: UIButton) {
        viewModel.playback()
    }
    
    private lazy var viewModel = PlaybackViewModel()
    
    deinit {
        print("deinit.")
    }
}
