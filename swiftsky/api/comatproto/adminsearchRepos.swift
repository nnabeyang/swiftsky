//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class AdminSearchRepos_Output: Codable {
        let type = "com.atproto.admin.searchRepos"
        var cursor: String?
        var repos: [AdminDefs_RepoView]

        init(cursor: String?, repos: [AdminDefs_RepoView]) {
            self.cursor = cursor
            self.repos = repos
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case repos
        }
    }

    static func AdminSearchRepos(cursor: String?, limit: Int?, q: String?, term: String?) async throws -> AdminSearchRepos_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q), "term": .string(term)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.searchRepos", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}
