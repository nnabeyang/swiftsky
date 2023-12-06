import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetListBlocks_Output: Codable {
        let type = "app.bsky.graph.getListBlocks"
        var cursor: String?
        var lists: [GraphDefs_ListView]
        init(cursor: String?, lists: [GraphDefs_ListView]) {
            self.cursor = cursor
            self.lists = lists
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case lists
        }
    }
    static func GraphGetListBlocks(cursor: String?, limit: Int?) async throws -> GraphGetListBlocks_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getListBlocks", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}