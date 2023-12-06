import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetFeedSkeleton_Output: Codable {
        let type = "app.bsky.feed.getFeedSkeleton"
        var cursor: String?
        var feed: [FeedDefs_SkeletonFeedPost]
        init(cursor: String?, feed: [FeedDefs_SkeletonFeedPost]) {
            self.cursor = cursor
            self.feed = feed
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case feed
        }
    }
    static func FeedGetFeedSkeleton(cursor: String?, feed: String, limit: Int?) async throws -> FeedGetFeedSkeleton_Output {
        let params: Parameters = ["cursor": .string(cursor), "feed": .string(feed), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getFeedSkeleton", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}