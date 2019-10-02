public protocol ObserverType {
    associatedtype Element
    
    func on(event: Event<Element>)
}

public extension ObserverType {
    func asObserver() -> Observer<Element> {
        return Observer(handler: on)
    }
}

public final class Observer<E>: ObserverType {
    private let _handler: (Event<E>) -> Void
    
    public init(handler: @escaping (Event<E>) -> Void) {
        _handler = handler
    }
    
    public func on(event: Event<E>) {
        _handler(event)
    }
}

public struct AnyObserver<E>: ObserverType {
    private let handler: (Event<E>) -> Void
    
    public init(handler: @escaping (Event<E>) -> Void) {
        self.handler = handler
    }
    
    public init(observer: Observer<E>) {
        self.handler = observer.on
    }
    
    public func on(event: Event<E>) {
        handler(event)
    }
}

