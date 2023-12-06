import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedGetTimelineSkeleton_Output: Codable {
        let type = "app.bsky.unspecced.getTimelineSkeleton"
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
    static func UnspeccedGetTimelineSkeleton(cursor: String?, limit: Int?) async throws -> UnspeccedGetTimelineSkeleton_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.unspecced.getTimelineSkeleton", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}