//
//  ViewController.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import UIKit

class ViewController: UIViewController {

    private lazy var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.callAPI()
    }
}

