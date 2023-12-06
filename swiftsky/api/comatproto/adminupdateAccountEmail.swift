import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminUpdateAccountEmail_Input: Codable {
        let type = "com.atproto.admin.updateAccountEmail"
        var account: String
        var email: String
        init(account: String, email: String) {
            self.account = account
            self.email = email
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case account
            case email
        }
    }
    static func AdminUpdateAccountEmail(input: AdminUpdateAccountEmail_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.updateAccountEmail", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}