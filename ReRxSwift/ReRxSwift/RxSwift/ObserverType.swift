//
//  ObserverType.swift
//  ReRxSwift
//
//  Created by Manh Pham on 9/30/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

protocol ObserverType {
    associatedtype Element
    
    func on(event: Event<Element>)
}
