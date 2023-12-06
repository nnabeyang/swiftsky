import SwiftAtproto
import Foundation
extension appbskytypes {
    class EmbedRecordWithMedia: Codable {
        let type = "app.bsky.embed.recordWithMedia"
        var media: EmbedRecordWithMedia_Media
        var record: EmbedRecord
        init(media: EmbedRecordWithMedia_Media, record: EmbedRecord) {
            self.media = media
            self.record = record
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case media
            case record
        }
    }
    enum EmbedRecordWithMedia_Media: Codable {
        case embedImages(EmbedImages)
        case embedExternal(EmbedExternal)
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
            }
        }
    }
    class EmbedRecordWithMedia_View: Codable {
        let type = "app.bsky.embed.recordWithMedia#view"
        var media: EmbedRecordWithMedia_View_Media
        var record: EmbedRecord_View
        init(media: EmbedRecordWithMedia_View_Media, record: EmbedRecord_View) {
            self.media = media
            self.record = record
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case media
            case record
        }
    }
    enum EmbedRecordWithMedia_View_Media: Codable {
        case embedImagesView(EmbedImages_View)
        case embedExternalView(EmbedExternal_View)
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
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .embedImagesView(value):
                try container.encode(value)
            case let .embedExternalView(value):
                try container.encode(value)
            }
        }
    }
}