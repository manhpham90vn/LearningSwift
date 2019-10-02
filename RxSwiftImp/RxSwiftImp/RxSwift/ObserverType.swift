//
//  ObserverType.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

protocol ObserverType {
    
    associatedtype Element
    
    func on(event: Event<Element>)
    
}
