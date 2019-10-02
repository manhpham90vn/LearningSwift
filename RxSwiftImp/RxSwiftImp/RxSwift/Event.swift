//
//  Event.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

enum Event<Element> {
    case next(Element)
    case error(Swift.Error)
    case completed
}
