import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedSearchPosts_Output: Codable {
        let type = "app.bsky.feed.searchPosts"
        var cursor: String?
        var hitsTotal: Int?
        var posts: [FeedDefs_PostView]
        init(cursor: String?, hitsTotal: Int?, posts: [FeedDefs_PostView]) {
            self.cursor = cursor
            self.hitsTotal = hitsTotal
            self.posts = posts
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case hitsTotal
            case posts
        }
    }
    static func FeedSearchPosts(cursor: String?, limit: Int?, q: String) async throws -> FeedSearchPosts_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.searchPosts", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}