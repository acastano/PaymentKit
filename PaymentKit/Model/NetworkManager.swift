import Foundation

protocol NetworkManager {
    func runAfter(_ completion: @escaping (() -> ()))
}
