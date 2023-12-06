//
//  notificationlistNotifications.swift
//  swiftsky
//

import Foundation

struct NotificationListNotificationsNotification: Decodable, Identifiable {
    var id = UUID()
    let author: ActorDefsProfileView?
    let cid: String
    let indexedAt: Date
    let isRead: Bool
    let reason: String
    let reasonSubject: String?
    var record: FeedPost? = nil
    var post: FeedDefsPostView? = nil
    let uri: String
    enum CodingKeys: String, CodingKey {
        case author
        case cid
        case indexedAt
        case isRead
        case reason
        case reasonSubject
        case uri
        case record
        case type = "$type"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(ActorDefsProfileView.self, forKey: .author)
        cid = try container.decode(String.self, forKey: .cid)
        indexedAt = try container.decode(Date.self, forKey: .indexedAt)
        isRead = try container.decode(Bool.self, forKey: .isRead)
        reason = try container.decode(String.self, forKey: .reason)
        reasonSubject = try container.decodeIfPresent(String.self, forKey: .reasonSubject)
        uri = try container.decode(String.self, forKey: .uri)
        if let nestedcontainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .record) {
            let type = try nestedcontainer.decodeIfPresent(String.self, forKey: .type)
            if type == "app.bsky.feed.post" {
                record = try container.decode(FeedPost.self, forKey: .record)
            }
        }
    }
}

struct NotificationListNotificationsInput: Encodable {
    let cursor: String?
    let limit: Int
    let seenAt: String?
}

struct NotificationListNotificationsOutput: Decodable {
    var cursor: String?
    var notifications: [NotificationListNotificationsNotification]
}

func NotificationListNotifications(limit: Int = 30, cursor: String? = nil) async throws -> NotificationListNotificationsOutput {
    try await Client.shared.fetch(
        endpoint: "app.bsky.notification.listNotifications", authorization: Client.shared.user.accessJwt,
        params: NotificationListNotificationsInput(cursor: cursor, limit: limit, seenAt: nil)
    )
}
