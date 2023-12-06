import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphBlock: Codable {
        let type = "app.bsky.graph.block"
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