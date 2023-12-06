import SwiftAtproto
import Foundation
extension appbskytypes {
    class UnspeccedDefs_SkeletonSearchActor: Codable {
        let type = "app.bsky.unspecced.defs#skeletonSearchActor"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    class UnspeccedDefs_SkeletonSearchPost: Codable {
        let type = "app.bsky.unspecced.defs#skeletonSearchPost"
        var uri: String
        init(uri: String) {
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case uri
        }
    }
}