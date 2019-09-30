//
//  ObservableType.swift
//  ReRxSwift
//
//  Created by Manh Pham on 9/30/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

protocol ObservableType {
    
    associatedtype Element
    
    func subscribe<Observer: ObserverType>(observer: Observer) -> Disposable where Observer.Element == Element
    
}
