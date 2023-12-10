//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class ActorSearchActors_Output: Codable {
        let type = "app.bsky.actor.searchActors"
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

    static func ActorSearchActors(cursor: String?, limit: Int?, q: String?, term: String?) async throws -> ActorSearchActors_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q), "term": .string(term)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.searchActors", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}
