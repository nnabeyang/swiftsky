//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class RepoStrongRef: Codable {
        var cid: String
        var uri: String

        init(cid: String, uri: String) {
            self.cid = cid
            self.uri = uri
        }

        enum CodingKeys: String, CodingKey {
            case cid
            case uri
        }
    }
}
