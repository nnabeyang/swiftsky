import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedThreadgate: Codable {
        let type = "app.bsky.feed.threadgate"
        var allow: [FeedThreadgate_Allow_Elem]?
        var createdAt: String
        var post: String
        init(allow: [FeedThreadgate_Allow_Elem]?, createdAt: String, post: String) {
            self.allow = allow
            self.createdAt = createdAt
            self.post = post
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case allow
            case createdAt
            case post
        }
    }
    enum FeedThreadgate_Allow_Elem: Codable {
        case feedThreadgateMentionRule(FeedThreadgate_MentionRule)
        case feedThreadgateFollowingRule(FeedThreadgate_FollowingRule)
        case feedThreadgateListRule(FeedThreadgate_ListRule)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.threadgate#mentionRule":
                self = try .feedThreadgateMentionRule(.init(from: decoder))
            case "app.bsky.feed.threadgate#followingRule":
                self = try .feedThreadgateFollowingRule(.init(from: decoder))
            case "app.bsky.feed.threadgate#listRule":
                self = try .feedThreadgateListRule(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedThreadgateMentionRule(value):
                try container.encode(value)
            case let .feedThreadgateFollowingRule(value):
                try container.encode(value)
            case let .feedThreadgateListRule(value):
                try container.encode(value)
            }
        }
    }
    class FeedThreadgate_FollowingRule: Codable {
        let type = "app.bsky.feed.threadgate#followingRule"
        init() {
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
    }
    class FeedThreadgate_ListRule: Codable {
        let type = "app.bsky.feed.threadgate#listRule"
        var list: String
        init(list: String) {
            self.list = list
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case list
        }
    }
    class FeedThreadgate_MentionRule: Codable {
        let type = "app.bsky.feed.threadgate#mentionRule"
        init() {
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
    }
}