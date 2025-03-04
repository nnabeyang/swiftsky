//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class EmbedRecord: Codable {
        var record: comatprototypes.RepoStrongRef

        init(record: comatprototypes.RepoStrongRef) {
            self.record = record
        }

        enum CodingKeys: String, CodingKey {
            case record
        }
    }

    class EmbedRecord_View: Codable {
        var record: EmbedRecord_View_Record

        init(record: EmbedRecord_View_Record) {
            self.record = record
        }

        enum CodingKeys: String, CodingKey {
            case record
        }
    }

    enum EmbedRecord_View_Record: Codable {
        case embedRecordViewRecord(EmbedRecord_ViewRecord)
        case embedRecordViewNotFound(EmbedRecord_ViewNotFound)
        case embedRecordViewBlocked(EmbedRecord_ViewBlocked)
        case feedDefsGeneratorView(FeedDefs_GeneratorView)
        case graphDefsListView(GraphDefs_ListView)

        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.embed.record#viewRecord":
                self = try .embedRecordViewRecord(.init(from: decoder))
            case "app.bsky.embed.record#viewNotFound":
                self = try .embedRecordViewNotFound(.init(from: decoder))
            case "app.bsky.embed.record#viewBlocked":
                self = try .embedRecordViewBlocked(.init(from: decoder))
            case "app.bsky.feed.defs#generatorView":
                self = try .feedDefsGeneratorView(.init(from: decoder))
            case "app.bsky.graph.defs#listView":
                self = try .graphDefsListView(.init(from: decoder))
            default:
                fatalError()
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .embedRecordViewRecord(value):
                try container.encode("app.bsky.embed.record#viewRecord", forKey: .type)
                try value.encode(to: encoder)
            case let .embedRecordViewNotFound(value):
                try container.encode("app.bsky.embed.record#viewNotFound", forKey: .type)
                try value.encode(to: encoder)
            case let .embedRecordViewBlocked(value):
                try container.encode("app.bsky.embed.record#viewBlocked", forKey: .type)
                try value.encode(to: encoder)
            case let .feedDefsGeneratorView(value):
                try container.encode("app.bsky.feed.defs#generatorView", forKey: .type)
                try value.encode(to: encoder)
            case let .graphDefsListView(value):
                try container.encode("app.bsky.graph.defs#listView", forKey: .type)
                try value.encode(to: encoder)
            }
        }
    }

    class EmbedRecord_ViewBlocked: Codable {
        var author: FeedDefs_BlockedAuthor
        var blocked: Bool
        var uri: String

        init(author: FeedDefs_BlockedAuthor, blocked: Bool, uri: String) {
            self.author = author
            self.blocked = blocked
            self.uri = uri
        }

        enum CodingKeys: String, CodingKey {
            case author
            case blocked
            case uri
        }
    }

    class EmbedRecord_ViewNotFound: Codable {
        var notFound: Bool
        var uri: String

        init(notFound: Bool, uri: String) {
            self.notFound = notFound
            self.uri = uri
        }

        enum CodingKeys: String, CodingKey {
            case notFound
            case uri
        }
    }

    class EmbedRecord_ViewRecord: Codable {
        var author: ActorDefs_ProfileViewBasic
        var cid: String
        var embeds: [EmbedRecord_ViewRecord_Embeds_Elem]?
        var indexedAt: String
        var labels: [comatprototypes.LabelDefs_Label]?
        var uri: String
        var value: LexiconTypeDecoder

        init(author: ActorDefs_ProfileViewBasic, cid: String, embeds: [EmbedRecord_ViewRecord_Embeds_Elem]?, indexedAt: String, labels: [comatprototypes.LabelDefs_Label]?, uri: String, value: LexiconTypeDecoder) {
            self.author = author
            self.cid = cid
            self.embeds = embeds
            self.indexedAt = indexedAt
            self.labels = labels
            self.uri = uri
            self.value = value
        }

        enum CodingKeys: String, CodingKey {
            case author
            case cid
            case embeds
            case indexedAt
            case labels
            case uri
            case value
        }
    }

    enum EmbedRecord_ViewRecord_Embeds_Elem: Codable {
        case embedImagesView(EmbedImages_View)
        case embedExternalView(EmbedExternal_View)
        case embedRecordView(EmbedRecord_View)
        case embedRecordWithMediaView(EmbedRecordWithMedia_View)

        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.embed.images#view":
                self = try .embedImagesView(.init(from: decoder))
            case "app.bsky.embed.external#view":
                self = try .embedExternalView(.init(from: decoder))
            case "app.bsky.embed.record#view":
                self = try .embedRecordView(.init(from: decoder))
            case "app.bsky.embed.recordWithMedia#view":
                self = try .embedRecordWithMediaView(.init(from: decoder))
            default:
                fatalError()
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .embedImagesView(value):
                try container.encode("app.bsky.embed.images#view", forKey: .type)
                try value.encode(to: encoder)
            case let .embedExternalView(value):
                try container.encode("app.bsky.embed.external#view", forKey: .type)
                try value.encode(to: encoder)
            case let .embedRecordView(value):
                try container.encode("app.bsky.embed.record#view", forKey: .type)
                try value.encode(to: encoder)
            case let .embedRecordWithMediaView(value):
                try container.encode("app.bsky.embed.recordWithMedia#view", forKey: .type)
                try value.encode(to: encoder)
            }
        }
    }
}
