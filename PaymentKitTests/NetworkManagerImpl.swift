import Foundation

final class NetworkManagerImpl: NetworkManager {
    func runAfter(_ completion: @escaping (() -> ())) {
        completion()
    }
}
