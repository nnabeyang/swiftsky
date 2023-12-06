import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedRepost: Codable {
        let type = "app.bsky.feed.repost"
        var createdAt: String
        var subject: comatprototypes.RepoStrongRef
        init(createdAt: String, subject: comatprototypes.RepoStrongRef) {
            self.createdAt = createdAt
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case subject
        }
    }
}