//
//  UIViewController+Rx.swift
//  Combinestagram
//
//  Created by Manh Pham on 9/10/19.
//  Copyright © 2019 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
  
  func alert(title: String, text: String?) -> Completable {
    return Completable.create(subscribe: { (completable) -> Disposable in
      let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: { (_) in
        completable(.completed)
      }))
      self.present(alertVC, animated: true, completion: nil)
      return Disposables.create {
        self.dismiss(animated: true, completion: nil)
      }
    })
  }
  
}
