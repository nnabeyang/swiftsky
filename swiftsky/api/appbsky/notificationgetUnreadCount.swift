import SwiftAtproto
import Foundation
extension appbskytypes {
    class NotificationGetUnreadCount_Output: Codable {
        let type = "app.bsky.notification.getUnreadCount"
        var count: Int
        init(count: Int) {
            self.count = count
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case count
        }
    }
    static func NotificationGetUnreadCount(seenAt: String?) async throws -> NotificationGetUnreadCount_Output {
        let params: Parameters = ["seenAt": .string(seenAt)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.notification.getUnreadCount", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}