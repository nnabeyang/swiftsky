import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetListFeed_Output: Codable {
        let type = "app.bsky.feed.getListFeed"
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
    static func FeedGetListFeed(cursor: String?, limit: Int?, list: String) async throws -> FeedGetListFeed_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "list": .string(list)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getListFeed", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}