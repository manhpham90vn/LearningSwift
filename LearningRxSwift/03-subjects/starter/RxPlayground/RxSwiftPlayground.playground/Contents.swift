import Foundation
import RxSwift
import RxCocoa

example(of: "PublishSubject") {
    
    let subject = PublishSubject<String>()
    
    subject.onNext("Manh")
    
    let subscriptionOne = subject.subscribe({ (event) in
        print(event)
    })
    
    subject.on(.next("Ngan"))
    subject.onNext("Minh Nhat")
    
    let subscriptionTwo = subject.subscribe({ (event) in
        print("2)", event.element ?? event)
    })
    
    subject.onNext("Gau")
    
    subject.onCompleted()
    
    subject.onNext("Em Gau")
}

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

example(of: "BehaviorSubject") {
    let subject = BehaviorSubject<String>.init(value: "test")
    let bag = DisposeBag()
    
    subject.subscribe({ (event) in
        print(event)
    })
    .disposed(by: bag)
    
    subject.onNext("Manh")
    
    subject.onError(MyError.anError)
    
    subject.subscribe({ (event) in
        print("2)", event)
    })
}

example(of: "ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let bag = DisposeBag()
    
    subject.on(.next("1"))
    subject.onNext("2")
    subject.onNext("3")
    
    subject.subscribe({ (event) in
        print(label: "1)", event: event)
    }).disposed(by: bag)
    
    subject.subscribe({ (event) in
        print(label: "2)", event: event)
    })
    
    subject.onNext("4")
    
    subject.subscribe({ (event) in
        print(label: "3)", event: event)
    })
    
    subject.onError(MyError.anError)
    subject.dispose()
}

example(of: "PublishReplay") {
    let relay = PublishRelay<String>()
    let bag = DisposeBag()
    
    relay.accept("Manh")
    
    relay.subscribe({ (event) in
        print(event)
    }).disposed(by: bag)
    
}

/*:
 Copyright (c) 2019 Razeware LLC

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
