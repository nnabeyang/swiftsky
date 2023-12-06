import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedLike: Codable {
        let type = "app.bsky.feed.like"
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