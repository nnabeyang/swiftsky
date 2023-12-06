import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerUpdateEmail_Input: Codable {
        let type = "com.atproto.server.updateEmail"
        var email: String
        var token: String?
        init(email: String, token: String?) {
            self.email = email
            self.token = token
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case email
            case token
        }
    }
    static func ServerUpdateEmail(input: ServerUpdateEmail_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.updateEmail", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}