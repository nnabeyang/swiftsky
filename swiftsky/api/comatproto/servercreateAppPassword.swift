import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerCreateAppPassword_AppPassword: Codable {
        let type = "com.atproto.server.createAppPassword#appPassword"
        var createdAt: String
        var name: String
        var password: String
        init(createdAt: String, name: String, password: String) {
            self.createdAt = createdAt
            self.name = name
            self.password = password
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case name
            case password
        }
    }
    class ServerCreateAppPassword_Input: Codable {
        let type = "com.atproto.server.createAppPassword"
        var name: String
        init(name: String) {
            self.name = name
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case name
        }
    }
    static func ServerCreateAppPassword(input: ServerCreateAppPassword_Input) async throws -> ServerCreateAppPassword_AppPassword {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.createAppPassword", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}