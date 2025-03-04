//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class GraphMuteActor_Input: Codable {
        var actor: String

        init(actor: String) {
            self.actor = actor
        }

        enum CodingKeys: String, CodingKey {
            case actor
        }
    }

    static func GraphMuteActor(client: any XRPCClientProtocol, input: GraphMuteActor_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "app.bsky.graph.muteActor", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
