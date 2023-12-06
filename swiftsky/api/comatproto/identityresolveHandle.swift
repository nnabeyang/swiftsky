import SwiftAtproto
import Foundation
extension comatprototypes {
    class IdentityResolveHandle_Output: Codable {
        let type = "com.atproto.identity.resolveHandle"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    static func IdentityResolveHandle(handle: String) async throws -> IdentityResolveHandle_Output {
        let params: Parameters = ["handle": .string(handle)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.identity.resolveHandle", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}