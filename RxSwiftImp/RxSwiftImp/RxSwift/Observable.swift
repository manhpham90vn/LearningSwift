//
//  Observable.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

class Observable<Element>: ObservalbeType {
    
    let handler: (Observer<Element>) -> Disposable
    
    init(handler: @escaping (Observer<Element>) -> Disposable) {
        self.handler = handler
    }
    
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.Element == Element {
        let compositeDisposable = CompositeDisposable()
        let subscription = handler(Observer<Element>.init(handler: { (event) in
            observer.on(event: event)
            switch event {
            case .error, .completed:
                compositeDisposable.dispose()
            case .next:
                break
            }
        }))
        compositeDisposable.add(disposable: subscription)
        return compositeDisposable
    }
    
}
