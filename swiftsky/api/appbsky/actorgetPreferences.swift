import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorGetPreferences_Output: Codable {
        let type = "app.bsky.actor.getPreferences"
        var preferences: [ActorDefs_Preferences_Elem]
        init(preferences: [ActorDefs_Preferences_Elem]) {
            self.preferences = preferences
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case preferences
        }
    }
    static func ActorGetPreferences() async throws -> ActorGetPreferences_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.getPreferences", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}