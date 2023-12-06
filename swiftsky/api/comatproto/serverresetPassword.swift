import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerResetPassword_Input: Codable {
        let type = "com.atproto.server.resetPassword"
        var password: String
        var token: String
        init(password: String, token: String) {
            self.password = password
            self.token = token
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case password
            case token
        }
    }
    static func ServerResetPassword(input: ServerResetPassword_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.resetPassword", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}