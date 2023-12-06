import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorGetSuggestions_Output: Codable {
        let type = "app.bsky.actor.getSuggestions"
        var actors: [ActorDefs_ProfileView]
        var cursor: String?
        init(actors: [ActorDefs_ProfileView], cursor: String?) {
            self.actors = actors
            self.cursor = cursor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actors
            case cursor
        }
    }
    static func ActorGetSuggestions(cursor: String?, limit: Int?) async throws -> ActorGetSuggestions_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.getSuggestions", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}