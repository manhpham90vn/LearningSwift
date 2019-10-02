final class CompositeDisposable: Disposable {
    private var isDisposed: Bool = false
    private var disposables: [Disposable] = []
    
    init() {}
    
    func add(disposable: Disposable) {
        if isDisposed {
            disposable.dispose()
            return
        }
        disposables.append(disposable)
    }
    
    func dispose() {
        if isDisposed { return }
        disposables.forEach {
            $0.dispose()
        }
        isDisposed = true
    }
}
