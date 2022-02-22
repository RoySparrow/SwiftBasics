//
//  NetworkHelper.swift
//  TestCombine
//
//  Created by RoyLi on 2022/2/22.
//

import Combine
import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private init() {}
    
    private let urlStr = "https://api.publicapis.org/entries"
    
    private var cancellable: [AnyCancellable] = []
    
    func call() {
        guard let url = URL(string: urlStr) else {
            print("URL is invalid.")
            return
        }
        
        print("start call.")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data, let jsonStr = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                print(jsonStr)
            }
            
            print("end call.")
        }
        task.resume()
    }
    
    func callWithCombine() {
        guard let url = URL(string: urlStr) else {
            print("URL is invalid.")
            return
        }
        
        let subscription = URLSession.shared.dataTaskPublisher(for: url)
            .sink { completion in
                switch completion {
                case .finished:
                    print("completion finished.")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data, response) in
                print("receive value.")
                if let jsonStr = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    print(jsonStr)
                }
            }
        cancellable.append(subscription)
    }
    
    deinit {
        cancellable.forEach({ $0.cancel() })
        cancellable.removeAll()
    }
}
