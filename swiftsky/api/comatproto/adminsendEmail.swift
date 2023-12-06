import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminSendEmail_Input: Codable {
        let type = "com.atproto.admin.sendEmail"
        var content: String
        var recipientDid: String
        var senderDid: String
        var subject: String?
        init(content: String, recipientDid: String, senderDid: String, subject: String?) {
            self.content = content
            self.recipientDid = recipientDid
            self.senderDid = senderDid
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case content
            case recipientDid
            case senderDid
            case subject
        }
    }
    class AdminSendEmail_Output: Codable {
        let type = "com.atproto.admin.sendEmail"
        var sent: Bool
        init(sent: Bool) {
            self.sent = sent
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case sent
        }
    }
    static func AdminSendEmail(input: AdminSendEmail_Input) async throws -> AdminSendEmail_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.sendEmail", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}