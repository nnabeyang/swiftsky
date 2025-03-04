//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    static func ActorGetProfile(client: any XRPCClientProtocol, actor: String) async throws -> ActorDefs_ProfileViewDetailed {
        let params: Parameters = ["actor": .string(actor)]
        return try await client.fetch(endpoint: "app.bsky.actor.getProfile", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
