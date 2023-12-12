//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class NotificationUpdateSeen_Input: Codable {
        var seenAt: String

        init(seenAt: String) {
            self.seenAt = seenAt
        }

        enum CodingKeys: String, CodingKey {
            case seenAt
        }
    }

    static func NotificationUpdateSeen(client: any XRPCClientProtocol, input: NotificationUpdateSeen_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "app.bsky.notification.updateSeen", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
