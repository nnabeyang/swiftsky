import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphList: Codable {
        let type = "app.bsky.graph.list"
        var avatar: LexBlob?
        var createdAt: String
        var description: String?
        var descriptionFacets: [RichtextFacet]?
        var labels: GraphList_Labels?
        var name: String
        var purpose: String
        init(avatar: LexBlob?, createdAt: String, description: String?, descriptionFacets: [RichtextFacet]?, labels: GraphList_Labels?, name: String, purpose: String) {
            self.avatar = avatar
            self.createdAt = createdAt
            self.description = description
            self.descriptionFacets = descriptionFacets
            self.labels = labels
            self.name = name
            self.purpose = purpose
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case createdAt
            case description
            case descriptionFacets
            case labels
            case name
            case purpose
        }
    }
    enum GraphList_Labels: Codable {
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