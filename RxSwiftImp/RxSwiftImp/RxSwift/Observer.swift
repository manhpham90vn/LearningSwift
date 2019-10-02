//
//  Observer.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

class Observer<Element>: ObserverType {

    let handler: (Event<Element>) -> Void
    
    init(handler: @escaping (Event<Element>) -> Void) {
        self.handler = handler
    }
    
    func on(event: Event<Element>) {
        handler(event)
    }
    
}
