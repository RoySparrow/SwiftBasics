//
//  RetainCycleViewController.swift
//  TestRetainCycle
//
//  Created by Roy Sparrow on 2020/10/28.
//  Copyright © 2020 SparrowStudio. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class RetainCycleViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
    }

    private func initLayout() {
        view.backgroundColor = .white
        
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testView.backgroundColor = .red
        view.addSubview(testView)
        
        let removeBtn = UIButton(frame: CGRect(x: 150, y: 0, width: 100, height: 100))
        removeBtn.backgroundColor = .blue
        removeBtn.setTitle("remove", for: .normal)
        removeBtn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(removeBtn)
        
        let closeBtn = UIButton(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
        closeBtn.backgroundColor = .green
        closeBtn.setTitle("close", for: .normal)
        closeBtn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(closeBtn)
        
        removeBtn.rx.tap
            .bind { [weak testView, weak self] in
                testView?.removeFromSuperview()
                
                let refCount = CFGetRetainCount(self)
                print("self refCount: \(refCount)")
            }.disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .bind{ [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    deinit {
        print("RetainCycleVC deinit.")
    }
}
