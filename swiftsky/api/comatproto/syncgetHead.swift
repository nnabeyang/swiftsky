import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncGetHead_Output: Codable {
        let type = "com.atproto.sync.getHead"
        var root: String
        init(root: String) {
            self.root = root
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case root
        }
    }
    static func SyncGetHead(did: String) async throws -> SyncGetHead_Output {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getHead", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}