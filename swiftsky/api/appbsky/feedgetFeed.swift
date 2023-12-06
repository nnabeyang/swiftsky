import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetFeed_Output: Codable {
        let type = "app.bsky.feed.getFeed"
        var cursor: String?
        var feed: [FeedDefs_FeedViewPost]
        init(cursor: String?, feed: [FeedDefs_FeedViewPost]) {
            self.cursor = cursor
            self.feed = feed
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case feed
        }
    }
    static func FeedGetFeed(cursor: String?, feed: String, limit: Int?) async throws -> FeedGetFeed_Output {
        let params: Parameters = ["cursor": .string(cursor), "feed": .string(feed), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getFeed", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}