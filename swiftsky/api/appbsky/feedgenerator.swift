import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedGenerator: Codable {
        let type = "app.bsky.feed.generator"
        var avatar: LexBlob?
        var createdAt: String
        var description: String?
        var descriptionFacets: [RichtextFacet]?
        var did: String
        var displayName: String
        var labels: FeedGenerator_Labels?
        init(avatar: LexBlob?, createdAt: String, description: String?, descriptionFacets: [RichtextFacet]?, did: String, displayName: String, labels: FeedGenerator_Labels?) {
            self.avatar = avatar
            self.createdAt = createdAt
            self.description = description
            self.descriptionFacets = descriptionFacets
            self.did = did
            self.displayName = displayName
            self.labels = labels
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case createdAt
            case description
            case descriptionFacets
            case did
            case displayName
            case labels
        }
    }
    enum FeedGenerator_Labels: Codable {
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