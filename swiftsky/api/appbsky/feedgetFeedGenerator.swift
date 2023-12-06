import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetFeedGenerator_Output: Codable {
        let type = "app.bsky.feed.getFeedGenerator"
        var isOnline: Bool
        var isValid: Bool
        var view: FeedDefs_GeneratorView
        init(isOnline: Bool, isValid: Bool, view: FeedDefs_GeneratorView) {
            self.isOnline = isOnline
            self.isValid = isValid
            self.view = view
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case isOnline
            case isValid
            case view
        }
    }
    static func FeedGetFeedGenerator(feed: String) async throws -> FeedGetFeedGenerator_Output {
        let params: Parameters = ["feed": .string(feed)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getFeedGenerator", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}