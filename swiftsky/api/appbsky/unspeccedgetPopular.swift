import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedGetPopular_Output: Codable {
        let type = "app.bsky.unspecced.getPopular"
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
    static func UnspeccedGetPopular(cursor: String?, includeNsfw: Bool?, limit: Int?) async throws -> UnspeccedGetPopular_Output {
        let params: Parameters = ["cursor": .string(cursor), "includeNsfw": .bool(includeNsfw), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.unspecced.getPopular", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}