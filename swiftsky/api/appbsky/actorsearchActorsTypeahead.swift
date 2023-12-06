import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorSearchActorsTypeahead_Output: Codable {
        let type = "app.bsky.actor.searchActorsTypeahead"
        var actors: [ActorDefs_ProfileViewBasic]
        init(actors: [ActorDefs_ProfileViewBasic]) {
            self.actors = actors
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actors
        }
    }
    static func ActorSearchActorsTypeahead(limit: Int?, q: String?, term: String?) async throws -> ActorSearchActorsTypeahead_Output {
        let params: Parameters = ["limit": .integer(limit), "q": .string(q), "term": .string(term)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.searchActorsTypeahead", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}