import Foundation
import SwiftAtprotoUtil
extension appbskytypes {
    class GraphGetFollowers_Output: Codable {
        let type = "app.bsky.graph.getFollowers"
        var cursor: String?
        var followers: [ActorDefs_ProfileView]
        var subject: ActorDefs_ProfileView
        init(cursor: String?, followers: [ActorDefs_ProfileView], subject: ActorDefs_ProfileView) {
            self.cursor = cursor
            self.followers = followers
            self.subject = subject
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case followers
            case subject
        }
    }

    static func GraphGetFollowers(actor: String, cursor: String?, limit: Int?) async throws -> GraphGetFollowers_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.xfetch(endpoint: "app.bsky.graph.getFollowers", httpMethod: .get, authorization: XRPCClient.shared.auth.accessJwt, params: params)
    }
}
