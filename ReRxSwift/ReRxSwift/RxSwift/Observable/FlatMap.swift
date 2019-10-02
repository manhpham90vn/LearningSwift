extension ObservableType {
    
    func flatMap<U>(_ transfrom: @escaping (Element) -> Observable<U>) -> Observable<U> {
        return Observable({ (observer) -> Disposable in
            return self.subscribe(observer: Observer { (event) in
                let composite = CompositeDisposable()
                switch event {
                case .next(let element):
                    let transformed = transfrom(element)
                    let disposable = transformed.subscribe(observer: Observer { _event in
                        switch _event {
                        case .next(let e):
                            observer.on(event: .next(e))
                        case .error(let err):
                            observer.on(event: .error(err))
                            composite.dispose()
                        case .completed:
                            observer.on(event: .completed)
                            composite.dispose()
                        }
                    })
                    composite.add(disposable: disposable)
                case .error(let e):
                    observer.on(event: .error(e))
                    composite.dispose()
                case .completed:
                    observer.on(event: .completed)
                    composite.dispose()
                }
            })
        })
    }
    
}
