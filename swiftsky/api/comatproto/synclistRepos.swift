import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncListRepos_Output: Codable {
        let type = "com.atproto.sync.listRepos"
        var cursor: String?
        var repos: [SyncListRepos_Repo]
        init(cursor: String?, repos: [SyncListRepos_Repo]) {
            self.cursor = cursor
            self.repos = repos
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case repos
        }
    }
    class SyncListRepos_Repo: Codable {
        let type = "com.atproto.sync.listRepos#repo"
        var did: String
        var head: String
        var rev: String
        init(did: String, head: String, rev: String) {
            self.did = did
            self.head = head
            self.rev = rev
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case head
            case rev
        }
    }
    static func SyncListRepos(cursor: String?, limit: Int?) async throws -> SyncListRepos_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.listRepos", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}