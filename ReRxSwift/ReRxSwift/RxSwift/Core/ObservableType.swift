protocol ObservableType {
    associatedtype Element
    
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.Element == Element
}
