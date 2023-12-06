import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetLikes_Like: Codable {
        let type = "app.bsky.feed.getLikes#like"
        var actor: ActorDefs_ProfileView
        var createdAt: String
        var indexedAt: String
        init(actor: ActorDefs_ProfileView, createdAt: String, indexedAt: String) {
            self.actor = actor
            self.createdAt = createdAt
            self.indexedAt = indexedAt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actor
            case createdAt
            case indexedAt
        }
    }
    class FeedGetLikes_Output: Codable {
        let type = "app.bsky.feed.getLikes"
        var cid: String?
        var cursor: String?
        var likes: [FeedGetLikes_Like]
        var uri: String
        init(cid: String?, cursor: String?, likes: [FeedGetLikes_Like], uri: String) {
            self.cid = cid
            self.cursor = cursor
            self.likes = likes
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case cursor
            case likes
            case uri
        }
    }
    static func FeedGetLikes(cid: String?, cursor: String?, limit: Int?, uri: String) async throws -> FeedGetLikes_Output {
        let params: Parameters = ["cid": .string(cid), "cursor": .string(cursor), "limit": .integer(limit), "uri": .string(uri)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getLikes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}