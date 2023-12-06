import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphMuteActorList_Input: Codable {
        let type = "app.bsky.graph.muteActorList"
        var list: String
        init(list: String) {
            self.list = list
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case list
        }
    }
    static func GraphMuteActorList(input: GraphMuteActorList_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.muteActorList", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}