import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetSuggestedFeeds_Output: Codable {
        let type = "app.bsky.feed.getSuggestedFeeds"
        var cursor: String?
        var feeds: [FeedDefs_GeneratorView]
        init(cursor: String?, feeds: [FeedDefs_GeneratorView]) {
            self.cursor = cursor
            self.feeds = feeds
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case feeds
        }
    }
    static func FeedGetSuggestedFeeds(cursor: String?, limit: Int?) async throws -> FeedGetSuggestedFeeds_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getSuggestedFeeds", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}