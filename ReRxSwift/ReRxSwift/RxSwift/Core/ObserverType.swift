protocol ObserverType {
    associatedtype Element
    
    func on(event: Event<Element>)
}
