//
//  Event.swift
//  ReRxSwift
//
//  Created by Manh Pham on 9/30/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

enum Event<T> {
    case next(T)
    case error(Error)
    case completed
}
