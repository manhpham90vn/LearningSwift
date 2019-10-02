//
//  ViewController.swift
//  ReRxSwift
//
//  Created by Manh Pham on 9/30/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        Observable<Int>.init { (observer) -> Disposable in
            observer.on(event: .next(1))
            observer.on(event: .next(2))
            observer.on(event: .completed)
            return AnonimousDisposable.init {
                print("disposed")
            }
        }
        .map({ $0 * 10 })
        .subscribe { (event) in
            print(event)
        }.dispose()
        
    }


}

