//
//  AnonimousDisposable.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

class AnonimousDisposable: Disposable {
    
    let handler: () -> Void
    
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    func dispose() {
        handler()
    }
    
}
