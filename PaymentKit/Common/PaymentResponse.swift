import Foundation

public enum PaymentResponse<T> {
    case success(response: T)
}
