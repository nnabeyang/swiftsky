import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedGetPopularFeedGenerators_Output: Codable {
        let type = "app.bsky.unspecced.getPopularFeedGenerators"
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
    static func UnspeccedGetPopularFeedGenerators(cursor: String?, limit: Int?, query: String?) async throws -> UnspeccedGetPopularFeedGenerators_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "query": .string(query)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.unspecced.getPopularFeedGenerators", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}