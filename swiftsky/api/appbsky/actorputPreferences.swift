import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorPutPreferences_Input: Codable {
        let type = "app.bsky.actor.putPreferences"
        var preferences: [ActorDefs_Preferences_Elem]
        init(preferences: [ActorDefs_Preferences_Elem]) {
            self.preferences = preferences
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case preferences
        }
    }
    static func ActorPutPreferences(input: ActorPutPreferences_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.putPreferences", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}