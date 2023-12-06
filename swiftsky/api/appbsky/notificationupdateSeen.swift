import SwiftAtproto
import Foundation
extension appbskytypes {
    class NotificationUpdateSeen_Input: Codable {
        let type = "app.bsky.notification.updateSeen"
        var seenAt: String
        init(seenAt: String) {
            self.seenAt = seenAt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case seenAt
        }
    }
    static func NotificationUpdateSeen(input: NotificationUpdateSeen_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.notification.updateSeen", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}