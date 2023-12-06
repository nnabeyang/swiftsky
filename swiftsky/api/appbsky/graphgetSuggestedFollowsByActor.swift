import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphGetSuggestedFollowsByActor_Output: Codable {
        let type = "app.bsky.graph.getSuggestedFollowsByActor"
        var suggestions: [ActorDefs_ProfileView]
        init(suggestions: [ActorDefs_ProfileView]) {
            self.suggestions = suggestions
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case suggestions
        }
    }
    static func GraphGetSuggestedFollowsByActor(actor: String) async throws -> GraphGetSuggestedFollowsByActor_Output {
        let params: Parameters = ["actor": .string(actor)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.graph.getSuggestedFollowsByActor", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}