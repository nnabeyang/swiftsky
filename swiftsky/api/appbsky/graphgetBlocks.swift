import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetBlocks_Output: Codable {
        let type = "app.bsky.graph.getBlocks"
        var blocks: [ActorDefs_ProfileView]
        var cursor: String?
        init(blocks: [ActorDefs_ProfileView], cursor: String?) {
            self.blocks = blocks
            self.cursor = cursor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blocks
            case cursor
        }
    }
    static func GraphGetBlocks(cursor: String?, limit: Int?) async throws -> GraphGetBlocks_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getBlocks", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}