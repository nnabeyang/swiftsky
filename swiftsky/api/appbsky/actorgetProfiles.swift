import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorGetProfiles_Output: Codable {
        let type = "app.bsky.actor.getProfiles"
        var profiles: [ActorDefs_ProfileViewDetailed]
        init(profiles: [ActorDefs_ProfileViewDetailed]) {
            self.profiles = profiles
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case profiles
        }
    }
    static func ActorGetProfiles(actors: [String]) async throws -> ActorGetProfiles_Output {
        let params: Parameters = ["actors": .array(actors)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.actor.getProfiles", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}