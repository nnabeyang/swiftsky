import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphUnmuteActor_Input: Codable {
        let type = "app.bsky.graph.unmuteActor"
        var actor: String
        init(actor: String) {
            self.actor = actor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actor
        }
    }
    static func GraphUnmuteActor(input: GraphUnmuteActor_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.unmuteActor", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}