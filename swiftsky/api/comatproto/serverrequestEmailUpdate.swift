import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerRequestEmailUpdate_Output: Codable {
        let type = "com.atproto.server.requestEmailUpdate"
        var tokenRequired: Bool
        init(tokenRequired: Bool) {
            self.tokenRequired = tokenRequired
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case tokenRequired
        }
    }
    static func ServerRequestEmailUpdate() async throws -> ServerRequestEmailUpdate_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.requestEmailUpdate", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none)
    }
}