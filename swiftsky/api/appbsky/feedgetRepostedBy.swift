import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGetRepostedBy_Output: Codable {
        let type = "app.bsky.feed.getRepostedBy"
        var cid: String?
        var cursor: String?
        var repostedBy: [ActorDefs_ProfileView]
        var uri: String
        init(cid: String?, cursor: String?, repostedBy: [ActorDefs_ProfileView], uri: String) {
            self.cid = cid
            self.cursor = cursor
            self.repostedBy = repostedBy
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case cursor
            case repostedBy
            case uri
        }
    }
    static func FeedGetRepostedBy(cid: String?, cursor: String?, limit: Int?, uri: String) async throws -> FeedGetRepostedBy_Output {
        let params: Parameters = ["cid": .string(cid), "cursor": .string(cursor), "limit": .integer(limit), "uri": .string(uri)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getRepostedBy", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}