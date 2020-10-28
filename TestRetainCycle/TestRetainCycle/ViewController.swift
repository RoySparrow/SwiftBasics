//
//  ViewController.swift
//  TestRetainCycle
//
//  Created by Roy Sparrow on 2020/10/28.
//  Copyright © 2020 SparrowStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func presentButtonTapped(_ sender: UIButton) {
        let vc = RetainCycleViewController()
        present(vc, animated: true, completion: nil)
    }
}

