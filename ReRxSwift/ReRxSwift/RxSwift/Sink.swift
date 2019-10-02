final class Sink<O: ObserverType>: Disposable {
    private var _disposed: Bool = false
    private let _forward: O
    private let _subscribtionHandler: (Observer<O.Element>) -> Disposable
    private let _composite = CompositeDisposable()
    
    init(forvard: O, subscribtionHandler: @escaping (Observer<O.Element>) -> Disposable) {
        _forward = forvard
        _subscribtionHandler = subscribtionHandler
    }
    
    func run() {
        let observer = Observer<O.Element>(handler: forward)
        _composite.add(disposable: _subscribtionHandler(observer))
    }
    
    private func forward(event: Event<O.Element>) {
        if _disposed {
            return
        }
        _forward.on(event: event)
        switch event {
        case .completed, .error:
            _disposed = true
            self.dispose()
        default:
            break
        }
    }
    
    func dispose() {
        _disposed = true
        _composite.dispose()
    }
}
