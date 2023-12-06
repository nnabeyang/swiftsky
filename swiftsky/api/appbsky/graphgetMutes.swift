import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetMutes_Output: Codable {
        let type = "app.bsky.graph.getMutes"
        var cursor: String?
        var mutes: [ActorDefs_ProfileView]
        init(cursor: String?, mutes: [ActorDefs_ProfileView]) {
            self.cursor = cursor
            self.mutes = mutes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case mutes
        }
    }
    static func GraphGetMutes(cursor: String?, limit: Int?) async throws -> GraphGetMutes_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getMutes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}