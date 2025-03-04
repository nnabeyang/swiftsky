//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class GraphGetLists_Output: Codable {
        var cursor: String?
        var lists: [GraphDefs_ListView]

        init(cursor: String?, lists: [GraphDefs_ListView]) {
            self.cursor = cursor
            self.lists = lists
        }

        enum CodingKeys: String, CodingKey {
            case cursor
            case lists
        }
    }

    static func GraphGetLists(client: any XRPCClientProtocol, actor: String, cursor: String?, limit: Int?) async throws -> GraphGetLists_Output {
        let params: Parameters = ["actor": .string(actor), "cursor": .string(cursor), "limit": .integer(limit)]
        return try await client.fetch(endpoint: "app.bsky.graph.getLists", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
