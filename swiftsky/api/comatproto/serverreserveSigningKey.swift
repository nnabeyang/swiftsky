import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerReserveSigningKey_Input: Codable {
        let type = "com.atproto.server.reserveSigningKey"
        var did: String?
        init(did: String?) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    class ServerReserveSigningKey_Output: Codable {
        let type = "com.atproto.server.reserveSigningKey"
        var signingKey: String
        init(signingKey: String) {
            self.signingKey = signingKey
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case signingKey
        }
    }
    static func ServerReserveSigningKey(input: ServerReserveSigningKey_Input) async throws -> ServerReserveSigningKey_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.reserveSigningKey", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}