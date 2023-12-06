import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoStrongRef: Codable {
        let type = "com.atproto.repo.strongRef"
        var cid: String
        var uri: String
        init(cid: String, uri: String) {
            self.cid = cid
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case uri
        }
    }
}