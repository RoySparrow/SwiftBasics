//
//  ViewController.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import Combine
import SnapKit
import UIKit

class ViewController: UIViewController {

    private lazy var viewModel = ViewModel()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private lazy var increaseBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(onIncreaseBtnTapped(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var decreaseBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("−", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(onDecreaseBtnTapped(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private var bags = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupConstraints()
        setupBinding()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        viewModel.callAPI()
//        viewModel.testMap()
    }
    
    private func setupConstraints() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        view.addSubview(increaseBtn)
        increaseBtn.snp.makeConstraints { make in
            make.width.equalTo(150.0)
            make.height.equalTo(75.0)
            make.bottom.equalTo(label.snp.top).offset(-20.0)
            make.centerX.equalToSuperview()
        }

        view.addSubview(decreaseBtn)
        decreaseBtn.snp.makeConstraints { make in
            make.width.equalTo(150.0)
            make.height.equalTo(75.0)
            make.top.equalTo(label.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        viewModel.$value
            .sink { [weak self] value in
                self?.label.text = "\(value)"
            }
            .store(in: &bags)
    }
    
    @objc
    private func onIncreaseBtnTapped(sender: UIButton) {
        viewModel.increase()
    }
    
    @objc
    private func onDecreaseBtnTapped(sender: UIButton) {
        viewModel.decrease()
    }
}

