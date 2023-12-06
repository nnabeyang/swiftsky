import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedDescribeFeedGenerator_Feed: Codable {
        let type = "app.bsky.feed.describeFeedGenerator#feed"
        var uri: String
        init(uri: String) {
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case uri
        }
    }
    class FeedDescribeFeedGenerator_Links: Codable {
        let type = "app.bsky.feed.describeFeedGenerator#links"
        var privacyPolicy: String?
        var termsOfService: String?
        init(privacyPolicy: String?, termsOfService: String?) {
            self.privacyPolicy = privacyPolicy
            self.termsOfService = termsOfService
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case privacyPolicy
            case termsOfService
        }
    }
    class FeedDescribeFeedGenerator_Output: Codable {
        let type = "app.bsky.feed.describeFeedGenerator"
        var did: String
        var feeds: [FeedDescribeFeedGenerator_Feed]
        var links: FeedDescribeFeedGenerator_Links?
        init(did: String, feeds: [FeedDescribeFeedGenerator_Feed], links: FeedDescribeFeedGenerator_Links?) {
            self.did = did
            self.feeds = feeds
            self.links = links
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case feeds
            case links
        }
    }
    static func FeedDescribeFeedGenerator() async throws -> FeedDescribeFeedGenerator_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.describeFeedGenerator", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}