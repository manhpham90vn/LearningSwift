final class Observer<Element>: ObserverType {
    private let _handler: (Event<Element>) -> Void
    
    init(handler: @escaping (Event<Element>) -> Void) {
        _handler = handler
    }
    
    func on(event: Event<Element>) {
        _handler(event)
    }
}

extension ObserverType {
    func asObserver() -> Observer<Element> {
        return Observer(handler: on)
    }
}
