import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedSearchActorsSkeleton_Output: Codable {
        let type = "app.bsky.unspecced.searchActorsSkeleton"
        var actors: [UnspeccedDefs_SkeletonSearchActor]
        var cursor: String?
        var hitsTotal: Int?
        init(actors: [UnspeccedDefs_SkeletonSearchActor], cursor: String?, hitsTotal: Int?) {
            self.actors = actors
            self.cursor = cursor
            self.hitsTotal = hitsTotal
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actors
            case cursor
            case hitsTotal
        }
    }
    static func UnspeccedSearchActorsSkeleton(cursor: String?, limit: Int?, q: String, typeahead: Bool?) async throws -> UnspeccedSearchActorsSkeleton_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q), "typeahead": .bool(typeahead)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.unspecced.searchActorsSkeleton", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}