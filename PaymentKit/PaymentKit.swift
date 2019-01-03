import Foundation

final public class PaymentKit {
    private var payments: [Payment] = []
    private let networkManager: NetworkManager = NetworkManagerImpl()

    public static let sharedInstance = PaymentKit()

    public func listPayments(completion: ((PaymentResponse<[Payment]>) -> ())) {
        completion(.success(response: payments))
    }

    public func makePayment(_ productId: String, description: String, value: String, completion: @escaping ((PaymentResponse<Bool>) -> ())) {
        networkManager.runAfter {
            let payment = Payment(id: "\(Date.timeIntervalBetween1970AndReferenceDate)", value: value, produtId: productId, productDescription: description)
            self.payments.append(payment)
            completion(.success(response: true))
        }
    }

    public func cancelPayment(_ paymentId: String, completion: @escaping ((PaymentResponse<Bool>) -> ())) {
        networkManager.runAfter {
            self.payments.removeAll(where: { $0.id == paymentId })
            completion(.success(response: true))
        }
    }

    public func payment(_ productId: String) -> Payment? {
        return payments.first(where: { $0.produtId == productId })
    }

    public func purchased(_ productId: String) -> Bool {
        return payment(productId) != nil
    }

    public func clear() {
        payments.removeAll()
    }
}
