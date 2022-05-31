import Foundation

class Box<T> {
    
    private var listener: ((T?) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(with value: T) {
        self.value = value
    }
    
    func bind(_ handler: @escaping (T?) -> ()) {
        listener = handler
    }
}
