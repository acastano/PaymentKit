import XCTest

final class PaymentKitTests: XCTestCase {

    func testMakePayment() {
        let paymentKit = PaymentKit()

        var success = false
        paymentKit.makePayment("1", description: "A description", value: "10.00") { result in
            success = true
        }
        XCTAssertTrue(success)
    }

    func testListPayment() {
        let paymentKit = PaymentKit()

        var success = false
        paymentKit.makePayment("1", description: "A description", value: "10.00") { result in
            success = true
        }
        XCTAssertTrue(success)

        var list = [Payment]()
        paymentKit.listPayments() { result in
            switch result {
            case .success(let response):
                list = response
            }
        }

        XCTAssertTrue(list.count == 1)

        if let payment = list.first {
            XCTAssert(payment.produtId == "1")
            XCTAssert(payment.value == "10.00")
            XCTAssert(payment.productDescription == "A description")
        } else {
            XCTFail()
        }
    }

    func testCancelPayment() {
        let paymentKit = PaymentKit()

        var success = false
        paymentKit.makePayment("1", description: "A description", value: "10.00") { result in
            success = true
        }
        XCTAssertTrue(success)

        var list = [Payment]()
        paymentKit.listPayments() { result in
            switch result {
            case .success(let response):
                list = response
            }
        }

        XCTAssertTrue(list.count == 1)

        if let payment = list.first {
            XCTAssert(payment.produtId == "1")
            XCTAssert(payment.value == "10.00")
            XCTAssert(payment.productDescription == "A description")

            var cancelPaymentSuccess = false
            paymentKit.cancelPayment(payment.id) { response in
                cancelPaymentSuccess = true
            }
            XCTAssertTrue(cancelPaymentSuccess)

            paymentKit.listPayments() { result in
                switch result {
                case .success(let response):
                    list = response
                }
            }
            XCTAssertTrue(list.count == 0)
        } else {
            XCTFail()
        }
    }

    func testIfPucharsed() {
        let paymentKit = PaymentKit()

        var success = false
        paymentKit.makePayment("1", description: "A description", value: "10.00") { result in
            success = true
        }
        XCTAssertTrue(success)

        XCTAssertTrue(paymentKit.purchased("1"))
    }

    func testFindPaymentForProduct() {
        let paymentKit = PaymentKit()

        var success = false
        paymentKit.makePayment("1", description: "A description", value: "10.00") { result in
            success = true
        }
        XCTAssertTrue(success)

        XCTAssertTrue(paymentKit.payment("1") != nil)
    }
}
