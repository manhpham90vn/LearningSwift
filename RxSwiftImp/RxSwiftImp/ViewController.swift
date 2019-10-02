//
//  ViewController.swift
//  RxSwiftImp
//
//  Created by Manh Pham on 10/2/19.
//  Copyright © 2019 Manh Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let observable = Observable<Int>.init { (observer) -> Disposable in
            observer.on(event: .next(1))
            observer.on(event: .next(2))
            observer.on(event: .completed)
            return AnonimousDisposable {
                print("disposed")
            }
        }
        
        observable.subscribe { (element) in
            print(element)
        }.dispose()
    }


}

