import Foundation

struct NetworkManagerImpl: NetworkManager {
    func runAfter(_ completion: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion()
        }
    }
}
