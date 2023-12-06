import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedSearchPostsSkeleton_Output: Codable {
        let type = "app.bsky.unspecced.searchPostsSkeleton"
        var cursor: String?
        var hitsTotal: Int?
        var posts: [UnspeccedDefs_SkeletonSearchPost]
        init(cursor: String?, hitsTotal: Int?, posts: [UnspeccedDefs_SkeletonSearchPost]) {
            self.cursor = cursor
            self.hitsTotal = hitsTotal
            self.posts = posts
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case hitsTotal
            case posts
        }
    }
    static func UnspeccedSearchPostsSkeleton(cursor: String?, limit: Int?, q: String) async throws -> UnspeccedSearchPostsSkeleton_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "q": .string(q)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.unspecced.searchPostsSkeleton", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}