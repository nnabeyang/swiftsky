import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerListAppPasswords_AppPassword: Codable {
        let type = "com.atproto.server.listAppPasswords#appPassword"
        var createdAt: String
        var name: String
        init(createdAt: String, name: String) {
            self.createdAt = createdAt
            self.name = name
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case name
        }
    }
    class ServerListAppPasswords_Output: Codable {
        let type = "com.atproto.server.listAppPasswords"
        var passwords: [ServerListAppPasswords_AppPassword]
        init(passwords: [ServerListAppPasswords_AppPassword]) {
            self.passwords = passwords
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case passwords
        }
    }
    static func ServerListAppPasswords() async throws -> ServerListAppPasswords_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.listAppPasswords", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}