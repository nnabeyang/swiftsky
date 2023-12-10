//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class GraphGetList_Output: Codable {
        let type = "app.bsky.graph.getList"
        var cursor: String?
        var items: [GraphDefs_ListItemView]
        var list: GraphDefs_ListView

        init(cursor: String?, items: [GraphDefs_ListItemView], list: GraphDefs_ListView) {
            self.cursor = cursor
            self.items = items
            self.list = list
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case items
            case list
        }
    }

    static func GraphGetList(cursor: String?, limit: Int?, list: String) async throws -> GraphGetList_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "list": .string(list)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getList", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}
