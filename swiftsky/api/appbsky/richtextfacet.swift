import SwiftAtproto
import Foundation
extension appbskytypes {
    class RichtextFacet: Codable {
        let type = "app.bsky.richtext.facet"
        var features: [RichtextFacet_Features_Elem]
        var index: RichtextFacet_ByteSlice
        init(features: [RichtextFacet_Features_Elem], index: RichtextFacet_ByteSlice) {
            self.features = features
            self.index = index
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case features
            case index
        }
    }
    class RichtextFacet_ByteSlice: Codable {
        let type = "app.bsky.richtext.facet#byteSlice"
        var byteEnd: Int
        var byteStart: Int
        init(byteEnd: Int, byteStart: Int) {
            self.byteEnd = byteEnd
            self.byteStart = byteStart
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case byteEnd
            case byteStart
        }
    }
    enum RichtextFacet_Features_Elem: Codable {
        case richtextFacetMention(RichtextFacet_Mention)
        case richtextFacetLink(RichtextFacet_Link)
        case richtextFacetTag(RichtextFacet_Tag)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.richtext.facet#mention":
                self = try .richtextFacetMention(.init(from: decoder))
            case "app.bsky.richtext.facet#link":
                self = try .richtextFacetLink(.init(from: decoder))
            case "app.bsky.richtext.facet#tag":
                self = try .richtextFacetTag(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .richtextFacetMention(value):
                try container.encode(value)
            case let .richtextFacetLink(value):
                try container.encode(value)
            case let .richtextFacetTag(value):
                try container.encode(value)
            }
        }
    }
    class RichtextFacet_Link: Codable {
        let type = "app.bsky.richtext.facet#link"
        var uri: String
        init(uri: String) {
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case uri
        }
    }
    class RichtextFacet_Mention: Codable {
        let type = "app.bsky.richtext.facet#mention"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    class RichtextFacet_Tag: Codable {
        let type = "app.bsky.richtext.facet#tag"
        var tag: String
        init(tag: String) {
            self.tag = tag
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case tag
        }
    }
}