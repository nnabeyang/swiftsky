import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetActorFeeds_Output: Codable {
        let type = "app.bsky.feed.getActorFeeds"
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
    static func FeedGetActorFeeds(actor: String, cursor: String?, limit: Int?) async throws -> FeedGetActorFeeds_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getActorFeeds", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}