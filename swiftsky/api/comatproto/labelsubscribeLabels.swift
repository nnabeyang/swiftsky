import SwiftAtproto
import Foundation
extension comatprototypes {
    class LabelSubscribeLabels_Info: Codable {
        let type = "com.atproto.label.subscribeLabels#info"
        var message: String?
        var name: String
        init(message: String?, name: String) {
            self.message = message
            self.name = name
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case message
            case name
        }
    }
    class LabelSubscribeLabels_Labels: Codable {
        let type = "com.atproto.label.subscribeLabels#labels"
        var labels: [LabelDefs_Label]
        var seq: Int
        init(labels: [LabelDefs_Label], seq: Int) {
            self.labels = labels
            self.seq = seq
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case labels
            case seq
        }
    }
}