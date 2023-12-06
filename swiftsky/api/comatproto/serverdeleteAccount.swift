import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerDeleteAccount_Input: Codable {
        let type = "com.atproto.server.deleteAccount"
        var did: String
        var password: String
        var token: String
        init(did: String, password: String, token: String) {
            self.did = did
            self.password = password
            self.token = token
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case password
            case token
        }
    }
    static func ServerDeleteAccount(input: ServerDeleteAccount_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.deleteAccount", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}