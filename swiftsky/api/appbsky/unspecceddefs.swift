//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class UnspeccedDefs_SkeletonSearchActor: Codable {
        var did: String

        init(did: String) {
            self.did = did
        }

        enum CodingKeys: String, CodingKey {
            case did
        }
    }

    class UnspeccedDefs_SkeletonSearchPost: Codable {
        var uri: String

        init(uri: String) {
            self.uri = uri
        }

        enum CodingKeys: String, CodingKey {
            case uri
        }
    }
}
