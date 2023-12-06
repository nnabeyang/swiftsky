import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorProfile: Codable {
        let type = "app.bsky.actor.profile"
        var avatar: LexBlob?
        var banner: LexBlob?
        var description: String?
        var displayName: String?
        var labels: ActorProfile_Labels?
        init(avatar: LexBlob?, banner: LexBlob?, description: String?, displayName: String?, labels: ActorProfile_Labels?) {
            self.avatar = avatar
            self.banner = banner
            self.description = description
            self.displayName = displayName
            self.labels = labels
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case banner
            case description
            case displayName
            case labels
        }
    }
    enum ActorProfile_Labels: Codable {
        case comAtprotoLabelDefsSelfLabels(comatprototypes.LabelDefs_SelfLabels)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.label.defs#selfLabels":
                self = try .comAtprotoLabelDefsSelfLabels(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                try container.encode(value)
            }
        }
    }
}