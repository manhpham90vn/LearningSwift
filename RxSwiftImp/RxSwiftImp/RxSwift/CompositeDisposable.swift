//
//  CompositeDisposable.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import Foundation

class CompositeDisposable: Disposable {
    
    private var isDisposed: Bool = false
    private var disposables: [Disposable] = []
    
    init() {}
    
    func add(disposable: Disposable) {
        if isDisposed {
            disposable.dispose()
            return
        }
        disposables.append(disposable)
    }
    
    func dispose() {
        if isDisposed { return }
        disposables.forEach {
            $0.dispose()
        }
        isDisposed = true
    }
    
}
