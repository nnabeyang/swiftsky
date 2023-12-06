import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncGetLatestCommit_Output: Codable {
        let type = "com.atproto.sync.getLatestCommit"
        var cid: String
        var rev: String
        init(cid: String, rev: String) {
            self.cid = cid
            self.rev = rev
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case rev
        }
    }
    static func SyncGetLatestCommit(did: String) async throws -> SyncGetLatestCommit_Output {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getLatestCommit", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}