import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncListBlobs_Output: Codable {
        let type = "com.atproto.sync.listBlobs"
        var cids: [String]
        var cursor: String?
        init(cids: [String], cursor: String?) {
            self.cids = cids
            self.cursor = cursor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cids
            case cursor
        }
    }
    static func SyncListBlobs(cursor: String?, did: String, limit: Int?, since: String?) async throws -> SyncListBlobs_Output {
        let params: Parameters = ["cursor": .string(cursor), "did": .string(did), "limit": .integer(limit), "since": .string(since)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.listBlobs", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}