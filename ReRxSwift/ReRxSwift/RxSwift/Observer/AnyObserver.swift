struct AnyObserver<Element>: ObserverType {
    private let handler: (Event<Element>) -> Void
    
    init(handler: @escaping (Event<Element>) -> Void) {
        self.handler = handler
    }
    
    init(observer: Observer<Element>) {
        self.handler = observer.on
    }
    
    func on(event: Event<Element>) {
        handler(event)
    }
}

