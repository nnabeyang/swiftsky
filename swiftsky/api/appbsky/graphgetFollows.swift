import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetFollows_Output: Codable {
        let type = "app.bsky.graph.getFollows"
        var cursor: String?
        var follows: [ActorDefs_ProfileView]
        var subject: ActorDefs_ProfileView
        init(cursor: String?, follows: [ActorDefs_ProfileView], subject: ActorDefs_ProfileView) {
            self.cursor = cursor
            self.follows = follows
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case follows
            case subject
        }
    }
    static func GraphGetFollows(actor: String, cursor: String?, limit: Int?) async throws -> GraphGetFollows_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getFollows", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}