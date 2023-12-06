import SwiftAtproto
import Foundation
extension comatprototypes {
    class IdentityUpdateHandle_Input: Codable {
        let type = "com.atproto.identity.updateHandle"
        var handle: String
        init(handle: String) {
            self.handle = handle
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case handle
        }
    }
    static func IdentityUpdateHandle(input: IdentityUpdateHandle_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.identity.updateHandle", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}