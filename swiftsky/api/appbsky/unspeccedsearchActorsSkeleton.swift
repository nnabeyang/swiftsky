//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class UnspeccedSearchActorsSkeleton_Output: Codable {
        var actors: [UnspeccedDefs_SkeletonSearchActor]
        var cursor: String?
        var hitsTotal: Int?

        init(actors: [UnspeccedDefs_SkeletonSearchActor], cursor: String?, hitsTotal: Int?) {
            self.actors = actors
            self.cursor = cursor
            self.hitsTotal = hitsTotal
        }

        enum CodingKeys: String, CodingKey {
            case actors
            case cursor
            case hitsTotal
        }
    }

    static func UnspeccedSearchActorsSkeleton(client: any XRPCClientProtocol, cursor: String?, limit: Int?, q: String, typeahead: Bool?) async throws -> UnspeccedSearchActorsSkeleton_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q), "typeahead": .bool(typeahead)]
        return try await client.fetch(endpoint: "app.bsky.unspecced.searchActorsSkeleton", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
