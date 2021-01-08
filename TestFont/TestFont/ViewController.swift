//
//  ViewController.swift
//  TestFont
//
//  Created by Roy Sparrow on 2021/1/8.
//  Copyright © 2021 SparrowStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var systemFontLabel: UILabel!
    
    @IBOutlet weak var customFontLabel: UILabel!
    
    private let testStr = "8888"
    
    private let fontSize: CGFloat = 12
    
    private let letterSpacing: CGFloat = -0.2
    
    private lazy var systemFont = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    
    private lazy var customFont = UIFont(name: "Avenir", size: 12)
//    private lazy var customFont = UIFont(name: "LiGothicMed", size: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printLabelWidth()
    }
    
    private func setup() {
        
        var fontFamilyNames = UIFont.familyNames
        fontFamilyNames.sort()
        fontFamilyNames.forEach({
            print("font family: \($0)")
        })
        
        systemFontLabel.font = systemFont
        if let customFont = customFont {
            customFontLabel.font = customFont
        }
        
        let attrStr = NSMutableAttributedString(string: testStr)
        attrStr.addAttribute(.kern, value: letterSpacing, range: NSMakeRange(0, attrStr.length))
        
        systemFontLabel.attributedText = attrStr
        systemFontLabel.textAlignment = .left
        customFontLabel.attributedText = attrStr
        customFontLabel.textAlignment = .left
    }
    
    private func printLabelWidth() {
        print("SystemFontLabel.width: \(systemFontLabel.frame.width) pt, with font: \(systemFontLabel.font!)")
        print("CustomFontLabel.width: \(customFontLabel.frame.width) pt, with font: \(customFontLabel.font!)")
    }
}

