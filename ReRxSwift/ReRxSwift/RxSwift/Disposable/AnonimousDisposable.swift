final class AnonimousDisposable: Disposable {
    
    private let _diposeHandler: () -> Void
    
    init(_ diposeClosure: @escaping () -> Void) {
        _diposeHandler = diposeClosure
    }
    
    func dispose() {
        _diposeHandler()
    }
    
}
