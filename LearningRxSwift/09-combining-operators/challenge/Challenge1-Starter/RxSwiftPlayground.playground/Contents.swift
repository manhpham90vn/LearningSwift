import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Start coding here!
example(of: "scan") {
    
    let bag = DisposeBag()
    
  Observable.of(1, 3, 5, 7, 9)
    .scan(0, accumulator: +)
    .subscribe(onNext: { value in
    print(value)
    })
    .disposed(by: bag)
    
}

example(of: "Challenge 1 - solution using zip") {
    let source = Observable.of(1, 3, 5, 7, 9)
    let bag = DisposeBag()
    
    let scanObservable = source.scan(0, accumulator: +)
    let observable = Observable.zip(source, scanObservable)
    
    observable.subscribe(onNext: { tuple in
        print("Value = \(tuple.0)   Running total = \(tuple.1)")
    })
    .disposed(by: bag)
}

example(of: "Challenge 1 - solution using just scan and a tuple") {
    let source = Observable.of(1, 3, 5, 7, 9)
    let bag = DisposeBag()
    
    source.scan((0, 0)) { acc, current in
        return (current, acc.1 + current)
    }
    .subscribe(onNext: { tuple in
        print("Value = \(tuple.0)   Running total = \(tuple.1)")
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
