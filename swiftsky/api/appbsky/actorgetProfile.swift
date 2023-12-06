import SwiftAtproto
import Foundation
extension appbskytypes {
    static func ActorGetProfile(actor: String) async throws -> ActorDefs_ProfileViewDetailed {
        let params: Parameters = ["actor": .string(actor)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.getProfile", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}