//
//  ViewModel.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import Foundation

class ViewModel {
    
    func callAPI() {
//        NetworkHelper.shared.call()
        NetworkHelper.shared.callWithCombine()
    }
}
