import Foundation
import RxSwift

example(of: "toArray") {
    let bag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5)
        .toArray()
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
}

example(of: "map") {
    let bag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5)
        .map({ $0 * 2 })
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
}

example(of: "enumerated") {
    let bag = DisposeBag()
    
    Observable.of(1, 2, 3 , 4, 5)
        .enumerated()
        .subscribe(onNext: { (index, element) in
            print(index, element)
        })
        .disposed(by: bag)
}

struct Student {
    let score: BehaviorSubject<Int>
}

example(of: "flatMap") {
    let disposeBag = DisposeBag()
    
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    let student = PublishSubject<Student>()
    
    student
        .flatMap {
            $0.score }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    student.onNext(laura)
    laura.score.onNext(85)
    student.onNext(charlotte)
    laura.score.onNext(95)
    charlotte.score.onNext(100)
}

example(of: "flatMapLatest") {
    let bag = DisposeBag()
    
    let laura = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    let student = PublishSubject<Student>()
    
    student
        .flatMapLatest({ $0.score })
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
    
    student.onNext(laura)
    laura.score.onNext(85)
    student.onNext(charlotte)
    
    laura.score.onNext(95)
    charlotte.score.onNext(100)
}

example(of: "materialize and dematerialize") {
    
    enum MyError: Error {
        case anError
    }
    
    let bag = DisposeBag()
    
    let laura = Student(score: BehaviorSubject<Int>(value: 80))
    let charlotte = Student(score: BehaviorSubject<Int>(value: 100))
    
    let student = BehaviorSubject(value: laura)
    
    let studentScore = student
        .flatMapLatest({ $0.score.materialize() })
    
    studentScore
        .filter({
            guard $0.error == nil else {
                print($0.error!)
                return false
            }
            return true
        })
        .dematerialize()
        .subscribe(onNext: { (element) in
            print(element)
        })
        .disposed(by: bag)
    
    laura.score.onNext(85)
    laura.score.onError(MyError.anError)
    laura.score.onNext(90)
    
    student.onNext(charlotte)
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
