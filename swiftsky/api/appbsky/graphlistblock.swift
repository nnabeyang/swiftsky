//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class GraphListblock: Codable {
        let type = "app.bsky.graph.listblock"
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
