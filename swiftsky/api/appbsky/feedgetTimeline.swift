import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetTimeline_Output: Codable {
        let type = "app.bsky.feed.getTimeline"
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
    static func FeedGetTimeline(algorithm: String?, cursor: String?, limit: Int?) async throws -> FeedGetTimeline_Output {
        let params: Parameters = ["algorithm": .string(algorithm), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getTimeline", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}