import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetPosts_Output: Codable {
        let type = "app.bsky.feed.getPosts"
        var posts: [FeedDefs_PostView]
        init(posts: [FeedDefs_PostView]) {
            self.posts = posts
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case posts
        }
    }
    static func FeedGetPosts(uris: [String]) async throws -> FeedGetPosts_Output {
        let params: Parameters = ["uris": .array(uris)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getPosts", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}