import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerConfirmEmail_Input: Codable {
        let type = "com.atproto.server.confirmEmail"
        var email: String
        var token: String
        init(email: String, token: String) {
            self.email = email
            self.token = token
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case email
            case token
        }
    }
    static func ServerConfirmEmail(input: ServerConfirmEmail_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.confirmEmail", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}