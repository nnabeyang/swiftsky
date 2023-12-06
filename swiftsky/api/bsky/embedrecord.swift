//
//  embedrecord.swift
//  swiftsky
//

import Foundation

struct EmbedRecordViewRecord: Decodable, Hashable {
    let author: ActorDefsProfileViewBasic
    let cid: String
    let embeds: [EmbedRecordViewRecordEmbeds]?
    let indexedAt: Date
    let uri: String
    let value: FeedPost
}

struct EmbedRecordViewRecordEmbeds: Decodable, Identifiable, Hashable {
    let id = UUID()
    let type: String?
    let images: [EmbedImagesViewImage]?
    let external: EmbedExternalViewExternal?
    var record: EmbedRecordViewRecord? = nil
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case images
        case external
        case record
        enum recordWithMedia: CodingKey {
            case record
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        switch type {
        case "app.bsky.embed.record#view":
            let nestedcontainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .record)
            if let nestedcontainer {
                let type = try nestedcontainer.decodeIfPresent(String.self, forKey: .type)
                if type == "app.bsky.embed.record#viewRecord" {
                    record = try container.decodeIfPresent(EmbedRecordViewRecord.self, forKey: .record)
                }
            }
        case "app.bsky.embed.recordWithMedia#view":
            let ncontainer = try container.nestedContainer(keyedBy: CodingKeys.recordWithMedia.self, forKey: .record)
            record = try ncontainer.decodeIfPresent(EmbedRecordViewRecord.self, forKey: .record)
        default:
            record = nil
        }
        images = try container.decodeIfPresent([EmbedImagesViewImage].self, forKey: .images)
        external = try container.decodeIfPresent(EmbedExternalViewExternal.self, forKey: .external)
    }
}
