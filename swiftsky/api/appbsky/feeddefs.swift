import SwiftAtproto
import Foundation
extension appbskytypes {
    class FeedDefs_BlockedAuthor: Codable {
        let type = "app.bsky.feed.defs#blockedAuthor"
        var did: String
        var viewer: ActorDefs_ViewerState?
        init(did: String, viewer: ActorDefs_ViewerState?) {
            self.did = did
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case viewer
        }
    }
    class FeedDefs_BlockedPost: Codable {
        let type = "app.bsky.feed.defs#blockedPost"
        var author: FeedDefs_BlockedAuthor
        var blocked: Bool
        var uri: String
        init(author: FeedDefs_BlockedAuthor, blocked: Bool, uri: String) {
            self.author = author
            self.blocked = blocked
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case author
            case blocked
            case uri
        }
    }
    class FeedDefs_FeedViewPost: Codable {
        let type = "app.bsky.feed.defs#feedViewPost"
        var post: FeedDefs_PostView
        var reason: FeedDefs_FeedViewPost_Reason?
        var reply: FeedDefs_ReplyRef?
        init(post: FeedDefs_PostView, reason: FeedDefs_FeedViewPost_Reason?, reply: FeedDefs_ReplyRef?) {
            self.post = post
            self.reason = reason
            self.reply = reply
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case post
            case reason
            case reply
        }
    }
    enum FeedDefs_FeedViewPost_Reason: Codable {
        case feedDefsReasonRepost(FeedDefs_ReasonRepost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#reasonRepost":
                self = try .feedDefsReasonRepost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsReasonRepost(value):
                try container.encode(value)
            }
        }
    }
    class FeedDefs_GeneratorView: Codable {
        let type = "app.bsky.feed.defs#generatorView"
        var avatar: String?
        var cid: String
        var creator: ActorDefs_ProfileView
        var description: String?
        var descriptionFacets: [RichtextFacet]?
        var did: String
        var displayName: String
        var indexedAt: String
        var likeCount: Int?
        var uri: String
        var viewer: FeedDefs_GeneratorViewerState?
        init(avatar: String?, cid: String, creator: ActorDefs_ProfileView, description: String?, descriptionFacets: [RichtextFacet]?, did: String, displayName: String, indexedAt: String, likeCount: Int?, uri: String, viewer: FeedDefs_GeneratorViewerState?) {
            self.avatar = avatar
            self.cid = cid
            self.creator = creator
            self.description = description
            self.descriptionFacets = descriptionFacets
            self.did = did
            self.displayName = displayName
            self.indexedAt = indexedAt
            self.likeCount = likeCount
            self.uri = uri
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case cid
            case creator
            case description
            case descriptionFacets
            case did
            case displayName
            case indexedAt
            case likeCount
            case uri
            case viewer
        }
    }
    class FeedDefs_GeneratorViewerState: Codable {
        let type = "app.bsky.feed.defs#generatorViewerState"
        var like: String?
        init(like: String?) {
            self.like = like
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case like
        }
    }
    class FeedDefs_NotFoundPost: Codable {
        let type = "app.bsky.feed.defs#notFoundPost"
        var notFound: Bool
        var uri: String
        init(notFound: Bool, uri: String) {
            self.notFound = notFound
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case notFound
            case uri
        }
    }
    class FeedDefs_PostView: Codable {
        let type = "app.bsky.feed.defs#postView"
        var author: ActorDefs_ProfileViewBasic
        var cid: String
        var embed: FeedDefs_PostView_Embed?
        var indexedAt: String
        var labels: [comatprototypes.LabelDefs_Label]?
        var likeCount: Int?
        var record: LexiconTypeDecoder
        var replyCount: Int?
        var repostCount: Int?
        var threadgate: FeedDefs_ThreadgateView?
        var uri: String
        var viewer: FeedDefs_ViewerState?
        init(author: ActorDefs_ProfileViewBasic, cid: String, embed: FeedDefs_PostView_Embed?, indexedAt: String, labels: [comatprototypes.LabelDefs_Label]?, likeCount: Int?, record: LexiconTypeDecoder, replyCount: Int?, repostCount: Int?, threadgate: FeedDefs_ThreadgateView?, uri: String, viewer: FeedDefs_ViewerState?) {
            self.author = author
            self.cid = cid
            self.embed = embed
            self.indexedAt = indexedAt
            self.labels = labels
            self.likeCount = likeCount
            self.record = record
            self.replyCount = replyCount
            self.repostCount = repostCount
            self.threadgate = threadgate
            self.uri = uri
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case author
            case cid
            case embed
            case indexedAt
            case labels
            case likeCount
            case record
            case replyCount
            case repostCount
            case threadgate
            case uri
            case viewer
        }
    }
    enum FeedDefs_PostView_Embed: Codable {
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
            var container = encoder.singleValueContainer()
            switch self {
            case let .embedImagesView(value):
                try container.encode(value)
            case let .embedExternalView(value):
                try container.encode(value)
            case let .embedRecordView(value):
                try container.encode(value)
            case let .embedRecordWithMediaView(value):
                try container.encode(value)
            }
        }
    }
    class FeedDefs_ReasonRepost: Codable {
        let type = "app.bsky.feed.defs#reasonRepost"
        var by: ActorDefs_ProfileViewBasic
        var indexedAt: String
        init(by: ActorDefs_ProfileViewBasic, indexedAt: String) {
            self.by = by
            self.indexedAt = indexedAt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case by
            case indexedAt
        }
    }
    class FeedDefs_ReplyRef: Codable {
        let type = "app.bsky.feed.defs#replyRef"
        var parent: FeedDefs_ReplyRef_Parent
        var root: FeedDefs_ReplyRef_Root
        init(parent: FeedDefs_ReplyRef_Parent, root: FeedDefs_ReplyRef_Root) {
            self.parent = parent
            self.root = root
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case parent
            case root
        }
    }
    enum FeedDefs_ReplyRef_Parent: Codable {
        case feedDefsPostView(FeedDefs_PostView)
        case feedDefsNotFoundPost(FeedDefs_NotFoundPost)
        case feedDefsBlockedPost(FeedDefs_BlockedPost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#postView":
                self = try .feedDefsPostView(.init(from: decoder))
            case "app.bsky.feed.defs#notFoundPost":
                self = try .feedDefsNotFoundPost(.init(from: decoder))
            case "app.bsky.feed.defs#blockedPost":
                self = try .feedDefsBlockedPost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsPostView(value):
                try container.encode(value)
            case let .feedDefsNotFoundPost(value):
                try container.encode(value)
            case let .feedDefsBlockedPost(value):
                try container.encode(value)
            }
        }
    }
    enum FeedDefs_ReplyRef_Root: Codable {
        case feedDefsPostView(FeedDefs_PostView)
        case feedDefsNotFoundPost(FeedDefs_NotFoundPost)
        case feedDefsBlockedPost(FeedDefs_BlockedPost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#postView":
                self = try .feedDefsPostView(.init(from: decoder))
            case "app.bsky.feed.defs#notFoundPost":
                self = try .feedDefsNotFoundPost(.init(from: decoder))
            case "app.bsky.feed.defs#blockedPost":
                self = try .feedDefsBlockedPost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsPostView(value):
                try container.encode(value)
            case let .feedDefsNotFoundPost(value):
                try container.encode(value)
            case let .feedDefsBlockedPost(value):
                try container.encode(value)
            }
        }
    }
    class FeedDefs_SkeletonFeedPost: Codable {
        let type = "app.bsky.feed.defs#skeletonFeedPost"
        var post: String
        var reason: FeedDefs_SkeletonFeedPost_Reason?
        init(post: String, reason: FeedDefs_SkeletonFeedPost_Reason?) {
            self.post = post
            self.reason = reason
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case post
            case reason
        }
    }
    enum FeedDefs_SkeletonFeedPost_Reason: Codable {
        case feedDefsSkeletonReasonRepost(FeedDefs_SkeletonReasonRepost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#skeletonReasonRepost":
                self = try .feedDefsSkeletonReasonRepost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsSkeletonReasonRepost(value):
                try container.encode(value)
            }
        }
    }
    class FeedDefs_SkeletonReasonRepost: Codable {
        let type = "app.bsky.feed.defs#skeletonReasonRepost"
        var repost: String
        init(repost: String) {
            self.repost = repost
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case repost
        }
    }
    class FeedDefs_ThreadgateView: Codable {
        let type = "app.bsky.feed.defs#threadgateView"
        var cid: String?
        var lists: [GraphDefs_ListViewBasic]?
        var record: LexiconTypeDecoder?
        var uri: String?
        init(cid: String?, lists: [GraphDefs_ListViewBasic]?, record: LexiconTypeDecoder?, uri: String?) {
            self.cid = cid
            self.lists = lists
            self.record = record
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case lists
            case record
            case uri
        }
    }
    class FeedDefs_ThreadViewPost: Codable {
        let type = "app.bsky.feed.defs#threadViewPost"
        var parent: FeedDefs_ThreadViewPost_Parent?
        var post: FeedDefs_PostView
        var replies: [FeedDefs_ThreadViewPost_Replies_Elem]?
        init(parent: FeedDefs_ThreadViewPost_Parent?, post: FeedDefs_PostView, replies: [FeedDefs_ThreadViewPost_Replies_Elem]?) {
            self.parent = parent
            self.post = post
            self.replies = replies
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case parent
            case post
            case replies
        }
    }
    enum FeedDefs_ThreadViewPost_Parent: Codable {
        case feedDefsThreadViewPost(FeedDefs_ThreadViewPost)
        case feedDefsNotFoundPost(FeedDefs_NotFoundPost)
        case feedDefsBlockedPost(FeedDefs_BlockedPost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#threadViewPost":
                self = try .feedDefsThreadViewPost(.init(from: decoder))
            case "app.bsky.feed.defs#notFoundPost":
                self = try .feedDefsNotFoundPost(.init(from: decoder))
            case "app.bsky.feed.defs#blockedPost":
                self = try .feedDefsBlockedPost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsThreadViewPost(value):
                try container.encode(value)
            case let .feedDefsNotFoundPost(value):
                try container.encode(value)
            case let .feedDefsBlockedPost(value):
                try container.encode(value)
            }
        }
    }
    enum FeedDefs_ThreadViewPost_Replies_Elem: Codable {
        case feedDefsThreadViewPost(FeedDefs_ThreadViewPost)
        case feedDefsNotFoundPost(FeedDefs_NotFoundPost)
        case feedDefsBlockedPost(FeedDefs_BlockedPost)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.feed.defs#threadViewPost":
                self = try .feedDefsThreadViewPost(.init(from: decoder))
            case "app.bsky.feed.defs#notFoundPost":
                self = try .feedDefsNotFoundPost(.init(from: decoder))
            case "app.bsky.feed.defs#blockedPost":
                self = try .feedDefsBlockedPost(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .feedDefsThreadViewPost(value):
                try container.encode(value)
            case let .feedDefsNotFoundPost(value):
                try container.encode(value)
            case let .feedDefsBlockedPost(value):
                try container.encode(value)
            }
        }
    }
    class FeedDefs_ViewerState: Codable {
        let type = "app.bsky.feed.defs#viewerState"
        var like: String?
        var replyDisabled: Bool?
        var repost: String?
        init(like: String?, replyDisabled: Bool?, repost: String?) {
            self.like = like
            self.replyDisabled = replyDisabled
            self.repost = repost
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case like
            case replyDisabled
            case repost
        }
    }
}