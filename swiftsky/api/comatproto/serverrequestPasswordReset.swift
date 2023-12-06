import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerRequestPasswordReset_Input: Codable {
        let type = "com.atproto.server.requestPasswordReset"
        var email: String
        init(email: String) {
            self.email = email
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case email
        }
    }
    static func ServerRequestPasswordReset(input: ServerRequestPasswordReset_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.requestPasswordReset", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}