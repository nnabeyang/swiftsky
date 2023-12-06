import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphListitem: Codable {
        let type = "app.bsky.graph.listitem"
        var createdAt: String
        var list: String
        var subject: String
        init(createdAt: String, list: String, subject: String) {
            self.createdAt = createdAt
            self.list = list
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case list
            case subject
        }
    }
}