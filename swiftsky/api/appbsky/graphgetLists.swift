import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetLists_Output: Codable {
        let type = "app.bsky.graph.getLists"
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
    static func GraphGetLists(actor: String, cursor: String?, limit: Int?) async throws -> GraphGetLists_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getLists", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}