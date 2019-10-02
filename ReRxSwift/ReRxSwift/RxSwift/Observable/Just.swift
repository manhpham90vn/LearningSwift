extension ObservableType {
    
    static func just(_ value: Element) -> Observable<Element> {
        return Observable { (observer) -> Disposable in
            observer.on(event: .next(value))
            observer.on(event: .completed)
            return NopeDisposable()
        }
    }
    
}
