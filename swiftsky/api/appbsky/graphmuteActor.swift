import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphMuteActor_Input: Codable {
        let type = "app.bsky.graph.muteActor"
        var actor: String
        init(actor: String) {
            self.actor = actor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case actor
        }
    }
    static func GraphMuteActor(input: GraphMuteActor_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.muteActor", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}