//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class LabelDefs_Label: Codable {
        var cid: String?
        var cts: String
        var neg: Bool?
        var src: String
        var uri: String
        var val: String

        init(cid: String?, cts: String, neg: Bool?, src: String, uri: String, val: String) {
            self.cid = cid
            self.cts = cts
            self.neg = neg
            self.src = src
            self.uri = uri
            self.val = val
        }

        enum CodingKeys: String, CodingKey {
            case cid
            case cts
            case neg
            case src
            case uri
            case val
        }
    }

    class LabelDefs_SelfLabel: Codable {
        var val: String

        init(val: String) {
            self.val = val
        }

        enum CodingKeys: String, CodingKey {
            case val
        }
    }

    class LabelDefs_SelfLabels: Codable {
        var values: [LabelDefs_SelfLabel]

        init(values: [LabelDefs_SelfLabel]) {
            self.values = values
        }

        enum CodingKeys: String, CodingKey {
            case values
        }
    }
}
