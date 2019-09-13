//
//  PHPhotoLibrary+Rx.swift
//  Combinestagram
//
//  Created by Manh Pham on 9/13/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Photos

extension PHPhotoLibrary {
  
  static var authorized: Observable<Bool> {
    return Observable.create({ (observer) -> Disposable in
      
      DispatchQueue.main.async {
        if authorizationStatus() == .authorized {
          observer.onNext(true)
          observer.onCompleted()
        } else {
          observer.onNext(false)
          requestAuthorization({ (newStatus) in
            observer.onNext(newStatus == .authorized)
            observer.onCompleted()
          })
        }
      }
      
      return Disposables.create()
    })
  }
  
}
