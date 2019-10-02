class Observable<Element>: ObservableType {
    private let _subscribeHandler: (Observer<Element>) -> Disposable
    
    init(_ subscribtionClosure: @escaping (Observer<Element>) -> Disposable) {
        _subscribeHandler = subscribtionClosure
    }
    
     func subscribe<O: ObserverType>(observer: O) -> Disposable where O.Element == Element {
        let sink = Sink(forvard: observer, subscribtionHandler: _subscribeHandler)
        sink.run()
        return sink
    }
}

extension ObservableType {
    
    func subscribe(onNext: @escaping (Element) -> Void) -> Disposable {
        return subscribe(observer: Observer { (event) in
            switch event {
            case .next(let element):
                onNext(element)
            default:
                break
            }
        })
    }
    
}
