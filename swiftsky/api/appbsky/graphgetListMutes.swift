import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetListMutes_Output: Codable {
        let type = "app.bsky.graph.getListMutes"
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
    static func GraphGetListMutes(cursor: String?, limit: Int?) async throws -> GraphGetListMutes_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getListMutes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}