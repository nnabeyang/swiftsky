import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedPost: Codable {
        let type = "app.bsky.feed.post"
        var createdAt: String
        var embed: FeedPost_Embed?
        var entities: [FeedPost_Entity]?
        var facets: [RichtextFacet]?
        var labels: FeedPost_Labels?
        var langs: [String]?
        var reply: FeedPost_ReplyRef?
        var tags: [String]?
        var text: String
        init(createdAt: String, embed: FeedPost_Embed?, entities: [FeedPost_Entity]?, facets: [RichtextFacet]?, labels: FeedPost_Labels?, langs: [String]?, reply: FeedPost_ReplyRef?, tags: [String]?, text: String) {
            self.createdAt = createdAt
            self.embed = embed
            self.entities = entities
            self.facets = facets
            self.labels = labels
            self.langs = langs
            self.reply = reply
            self.tags = tags
            self.text = text
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case embed
            case entities
            case facets
            case labels
            case langs
            case reply
            case tags
            case text
        }
    }
    enum FeedPost_Embed: Codable {
        case embedImages(EmbedImages)
        case embedExternal(EmbedExternal)
        case embedRecord(EmbedRecord)
        case embedRecordWithMedia(EmbedRecordWithMedia)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.embed.images":
                self = try .embedImages(.init(from: decoder))
            case "app.bsky.embed.external":
                self = try .embedExternal(.init(from: decoder))
            case "app.bsky.embed.record":
                self = try .embedRecord(.init(from: decoder))
            case "app.bsky.embed.recordWithMedia":
                self = try .embedRecordWithMedia(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .embedImages(value):
                try container.encode(value)
            case let .embedExternal(value):
                try container.encode(value)
            case let .embedRecord(value):
                try container.encode(value)
            case let .embedRecordWithMedia(value):
                try container.encode(value)
            }
        }
    }
    class FeedPost_Entity: Codable {
        var index: FeedPost_TextSlice
        var type: String
        var value: String
        init(index: FeedPost_TextSlice, type: String, value: String) {
            self.index = index
            self.type = type
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case index
            case type
            case value
        }
    }
    enum FeedPost_Labels: Codable {
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
    class FeedPost_ReplyRef: Codable {
        let type = "app.bsky.feed.post#replyRef"
        var parent: comatprototypes.RepoStrongRef
        var root: comatprototypes.RepoStrongRef
        init(parent: comatprototypes.RepoStrongRef, root: comatprototypes.RepoStrongRef) {
            self.parent = parent
            self.root = root
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case parent
            case root
        }
    }
    class FeedPost_TextSlice: Codable {
        let type = "app.bsky.feed.post#textSlice"
        var end: Int
        var start: Int
        init(end: Int, start: Int) {
            self.end = end
            self.start = start
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case end
            case start
        }
    }
}