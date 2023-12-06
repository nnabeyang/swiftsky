import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphFollow: Codable {
        let type = "app.bsky.graph.follow"
        var createdAt: String
        var subject: String
        init(createdAt: String, subject: String) {
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