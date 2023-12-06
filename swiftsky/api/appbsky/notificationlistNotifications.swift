import SwiftAtproto
import Foundation
extension appbskytypes {
    class NotificationListNotifications_Notification: Codable {
        let type = "app.bsky.notification.listNotifications#notification"
        var author: ActorDefs_ProfileView
        var cid: String
        var indexedAt: String
        var isRead: Bool
        var labels: [comatprototypes.LabelDefs_Label]?
        var reason: String
        var reasonSubject: String?
        var record: LexiconTypeDecoder
        var uri: String
        init(author: ActorDefs_ProfileView, cid: String, indexedAt: String, isRead: Bool, labels: [comatprototypes.LabelDefs_Label]?, reason: String, reasonSubject: String?, record: LexiconTypeDecoder, uri: String) {
            self.author = author
            self.cid = cid
            self.indexedAt = indexedAt
            self.isRead = isRead
            self.labels = labels
            self.reason = reason
            self.reasonSubject = reasonSubject
            self.record = record
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case author
            case cid
            case indexedAt
            case isRead
            case labels
            case reason
            case reasonSubject
            case record
            case uri
        }
    }
    class NotificationListNotifications_Output: Codable {
        let type = "app.bsky.notification.listNotifications"
        var cursor: String?
        var notifications: [NotificationListNotifications_Notification]
        init(cursor: String?, notifications: [NotificationListNotifications_Notification]) {
            self.cursor = cursor
            self.notifications = notifications
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case notifications
        }
    }
    static func NotificationListNotifications(cursor: String?, limit: Int?, seenAt: String?) async throws -> NotificationListNotifications_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "seenAt": .string(seenAt)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.notification.listNotifications", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}