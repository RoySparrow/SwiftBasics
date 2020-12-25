//
//  ViewController.swift
//  TestLoadImage
//
//  Created by Roy Sparrow on 2020/12/24.
//  Copyright © 2020 SparrowStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var assetsImageView: UIImageView!
    
    @IBOutlet weak var forderImageView: UIImageView!
    
    private lazy var imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        assetsImageView.image = imageLoader.loadImageFromAssets(name: "sparrow")
        forderImageView.image = imageLoader.loadImageFromForder(name: "sparrow")
    }
}

