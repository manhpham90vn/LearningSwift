//
//  ObservableType.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

protocol ObservalbeType {
    associatedtype Element
    
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.Element == Element
}

extension ObservalbeType {
    
    func subscribe(onNext: @escaping (Element) -> Void) -> Disposable {
        return subscribe(observer: Observer<Element>.init(handler: { (event) in
            switch event {
            case .next(let element):
                onNext(element)
            default:
                break
            }
        }))
    }
    
}
