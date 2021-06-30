import Foundation

enum OutgoingEvent {
    case kycStarted(KycStartedPayload)
    case kycSubmitted(KycSubmittedPayload)
    case kycSuccess(KycSuccessPayload)
    case kycAborted(KycAbortedPayload)
    case kycError(KycErrorPayload)
    case navigationBack
}

extension OutgoingEvent: MessageEventEncodable {
    enum Error: Swift.Error { case stringEncodingFailed }
    
    func messagePayload() throws -> String {
        let type: String
        let payloadData: Data?
        switch self {
        case .kycStarted(let payload):
            type = "KYC_STARTED"
            payloadData = try encoder.encode(payload)
        case .kycSubmitted(let payload):
            type = "KYC_SUBMITTED"
            payloadData = try encoder.encode(payload)
        case .kycSuccess(let payload):
            type = "KYC_SUCCESS"
            payloadData = try encoder.encode(payload)
        case .kycAborted(let payload):
            type = "KYC_ABORTED"
            payloadData = try encoder.encode(payload)
        case .kycError(let payload):
            type = "KYC_ERROR"
            payloadData = try encoder.encode(payload)
        case .navigationBack:
            type = "NAVIGATION_BACK"
            payloadData = nil
        }
        
        let serializedPayload: Any?
        if let payloadData = payloadData {
            serializedPayload = try JSONSerialization.jsonObject(with: payloadData)
        } else {
            serializedPayload = nil
        }
        let dictionary = ["type": type,
                          "payload": serializedPayload]
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
        if let jsonString = String(data: jsonData, encoding: .utf8) { return jsonString }
        else { throw Error.stringEncodingFailed }
    }
}

// MARK: Payloads

struct KycStartedPayload: Encodable {
    let verificationId: Int
}

struct KycSubmittedPayload: Encodable {
    let verificationId: Int
    let identityAccessKey: String
}

struct KycSuccessPayload: Encodable {
    let verificationId: Int
    let identityAccessKey: String
}

struct KycAbortedPayload: Encodable {
    let verificationId: Int
}

struct KycErrorPayload: Encodable {
    let verificationId: Int
}
