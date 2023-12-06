import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphUnmuteActorList_Input: Codable {
        let type = "app.bsky.graph.unmuteActorList"
        var list: String
        init(list: String) {
            self.list = list
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case list
        }
    }
    static func GraphUnmuteActorList(input: GraphUnmuteActorList_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.unmuteActorList", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}