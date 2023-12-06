import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerRevokeAppPassword_Input: Codable {
        let type = "com.atproto.server.revokeAppPassword"
        var name: String
        init(name: String) {
            self.name = name
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case name
        }
    }
    static func ServerRevokeAppPassword(input: ServerRevokeAppPassword_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.revokeAppPassword", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}