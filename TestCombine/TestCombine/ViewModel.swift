//
//  ViewModel.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import Combine
import Foundation

class ViewModel {
    
    private let a = CurrentValueSubject<Int, Error>(10)
    
    private var bags: [AnyCancellable] = []
    
    @Published
    private(set) var value = 0
    
    func callAPI() {
//        NetworkHelper.shared.call()
        NetworkHelper.shared.callWithCombine()
    }
    
    func testMap() {
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
        
//        a.sink { completion in
//            print(completion)
//        } receiveValue: { value in
//            print(value)
//        }.store(in: &bags)
//        a.value += 1
//        a.value = 60
//        a.value = -100
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
