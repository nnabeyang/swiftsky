import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetFeedGenerators_Output: Codable {
        let type = "app.bsky.feed.getFeedGenerators"
        var feeds: [FeedDefs_GeneratorView]
        init(feeds: [FeedDefs_GeneratorView]) {
            self.feeds = feeds
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case feeds
        }
    }
    static func FeedGetFeedGenerators(feeds: [String]) async throws -> FeedGetFeedGenerators_Output {
        let params: Parameters = ["feeds": .array(feeds)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getFeedGenerators", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}