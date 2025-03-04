//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class FeedGetActorLikes_Output: Codable {
        var cursor: String?
        var feed: [FeedDefs_FeedViewPost]

        init(cursor: String?, feed: [FeedDefs_FeedViewPost]) {
            self.cursor = cursor
            self.feed = feed
        }

        enum CodingKeys: String, CodingKey {
            case cursor
            case feed
        }
    }

    static func FeedGetActorLikes(client: any XRPCClientProtocol, actor: String, cursor: String?, limit: Int?) async throws -> FeedGetActorLikes_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await client.fetch(endpoint: "app.bsky.feed.getActorLikes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
