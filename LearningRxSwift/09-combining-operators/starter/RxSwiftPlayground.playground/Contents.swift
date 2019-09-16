import Foundation
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Start coding here!
example(of: "startWith") {
    
  let bag = DisposeBag()

  Observable.of(2, 3, 4)
    .startWith(1)
    .subscribe(onNext: { value in
    print(value)
    })
    .disposed(by: bag)
}

example(of: "Observable.concat") {
    let bag = DisposeBag()
    
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    
    Observable.concat(first, second)
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
}

example(of: "concat") {
    let bag = DisposeBag()
    
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    
    second.concat(first)
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
}

example(of: "concatMap") {
    let bag = DisposeBag()
    
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6, 7)
    
    first
        .concatMap({ (element) -> Observable<Int> in
            return second
        })
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
}

example(of: "merge") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let bag = DisposeBag()
    
    Observable.of(left.asObserver(), right.asObserver())
        .merge()
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
    
    left.onNext("Manh")
    right.onNext("Bui")
    left.onNext("Pham")
    left.onNext("Van")
}

example(of: "combineLatest") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let bag = DisposeBag()
    
    Observable
        .combineLatest(left, right) { leftValue, rightValue in
            return "\(leftValue) \(rightValue)"
        }
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
    
    left.onNext("Manh")
    right.onNext("Bui")
    left.onNext("Pham")
    left.onNext("Van")
}

example(of: "combine user choice and value") {
    let choice: Observable<DateFormatter.Style> = Observable.of(.short, .long)
    let dates = Observable.of(Date())
    let bag = DisposeBag()
    
    Observable
        .combineLatest(choice, dates) { format, when -> String in
            let formatter = DateFormatter()
            formatter.dateStyle = format
            return formatter.string(from: when)
        }
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
}

example(of: "zip") {
    enum Weather {
        case cloudy
        case sunny
    }
    
    let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
    let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")
    let bag = DisposeBag()
    
    Observable
        .zip(left, right) { weather, city in
       return "\(weather) at \(city)"
        }
        .subscribe(onNext: { (data) in
            print(data)
        })
        .disposed(by: bag)
    
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
