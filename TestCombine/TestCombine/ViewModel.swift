//
//  ViewModel.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import Combine
import Foundation

class ViewModel {
    
    private let passPublisher = PassthroughSubject<Int, Never>()
    
    private var bags: [AnyCancellable] = []
    
    @Published
    private(set) var value = 0
    
    func callAPI() {
//        NetworkHelper.shared.call()
        NetworkHelper.shared.callWithCombine()
    }
    
    func test() {
//        let value = 10
//        value.words.publisher
//            .map({ $0 + 1 })
//            .sink(receiveValue: { value in
//                print(value)
//            }).store(in: &bags)
        
//        [1, 2, 3, 4, 5]
//            .publisher
//            .filter({ $0 >= 3 })
//            .sink { value in
//                print(value)
//            }.store(in: &bags)
        
        passPublisher
            .sink { value in
                print("pass \(value)")
            }.store(in: &bags)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.passPublisher.send(100)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
            self?.passPublisher.send(500)
        }
    }
    
    func increase() {
        value += 1
    }
    
    func decrease() {
        value -= 1
    }
    
    deinit {
        bags.forEach({ $0.cancel() })
        bags.removeAll()
    }
}

//struct Binding {
//
//    let onIncreaseBtnTapped: AnyPublisher<Void, Error>
//
//    let onDecreaseBtnTapped: AnyPublisher<Void, Error>
//}
