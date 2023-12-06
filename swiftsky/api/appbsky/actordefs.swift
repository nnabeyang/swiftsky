import SwiftAtproto
import Foundation
extension appbskytypes {
    class ActorDefs_AdultContentPref: Codable {
        let type = "app.bsky.actor.defs#adultContentPref"
        var enabled: Bool
        init(enabled: Bool) {
            self.enabled = enabled
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case enabled
        }
    }
    class ActorDefs_ContentLabelPref: Codable {
        let type = "app.bsky.actor.defs#contentLabelPref"
        var label: String
        var visibility: String
        init(label: String, visibility: String) {
            self.label = label
            self.visibility = visibility
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case label
            case visibility
        }
    }
    class ActorDefs_FeedViewPref: Codable {
        let type = "app.bsky.actor.defs#feedViewPref"
        var feed: String
        var hideQuotePosts: Bool?
        var hideReplies: Bool?
        var hideRepliesByLikeCount: Int?
        var hideRepliesByUnfollowed: Bool?
        var hideReposts: Bool?
        init(feed: String, hideQuotePosts: Bool?, hideReplies: Bool?, hideRepliesByLikeCount: Int?, hideRepliesByUnfollowed: Bool?, hideReposts: Bool?) {
            self.feed = feed
            self.hideQuotePosts = hideQuotePosts
            self.hideReplies = hideReplies
            self.hideRepliesByLikeCount = hideRepliesByLikeCount
            self.hideRepliesByUnfollowed = hideRepliesByUnfollowed
            self.hideReposts = hideReposts
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case feed
            case hideQuotePosts
            case hideReplies
            case hideRepliesByLikeCount
            case hideRepliesByUnfollowed
            case hideReposts
        }
    }
    class ActorDefs_PersonalDetailsPref: Codable {
        let type = "app.bsky.actor.defs#personalDetailsPref"
        var birthDate: String?
        init(birthDate: String?) {
            self.birthDate = birthDate
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case birthDate
        }
    }
    enum ActorDefs_Preferences_Elem: Codable {
        case actorDefsAdultContentPref(ActorDefs_AdultContentPref)
        case actorDefsContentLabelPref(ActorDefs_ContentLabelPref)
        case actorDefsSavedFeedsPref(ActorDefs_SavedFeedsPref)
        case actorDefsPersonalDetailsPref(ActorDefs_PersonalDetailsPref)
        case actorDefsFeedViewPref(ActorDefs_FeedViewPref)
        case actorDefsThreadViewPref(ActorDefs_ThreadViewPref)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "app.bsky.actor.defs#adultContentPref":
                self = try .actorDefsAdultContentPref(.init(from: decoder))
            case "app.bsky.actor.defs#contentLabelPref":
                self = try .actorDefsContentLabelPref(.init(from: decoder))
            case "app.bsky.actor.defs#savedFeedsPref":
                self = try .actorDefsSavedFeedsPref(.init(from: decoder))
            case "app.bsky.actor.defs#personalDetailsPref":
                self = try .actorDefsPersonalDetailsPref(.init(from: decoder))
            case "app.bsky.actor.defs#feedViewPref":
                self = try .actorDefsFeedViewPref(.init(from: decoder))
            case "app.bsky.actor.defs#threadViewPref":
                self = try .actorDefsThreadViewPref(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .actorDefsAdultContentPref(value):
                try container.encode(value)
            case let .actorDefsContentLabelPref(value):
                try container.encode(value)
            case let .actorDefsSavedFeedsPref(value):
                try container.encode(value)
            case let .actorDefsPersonalDetailsPref(value):
                try container.encode(value)
            case let .actorDefsFeedViewPref(value):
                try container.encode(value)
            case let .actorDefsThreadViewPref(value):
                try container.encode(value)
            }
        }
    }
    class ActorDefs_ProfileView: Codable {
        let type = "app.bsky.actor.defs#profileView"
        var avatar: String?
        var description: String?
        var did: String
        var displayName: String?
        var handle: String
        var indexedAt: String?
        var labels: [comatprototypes.LabelDefs_Label]?
        var viewer: ActorDefs_ViewerState?
        init(avatar: String?, description: String?, did: String, displayName: String?, handle: String, indexedAt: String?, labels: [comatprototypes.LabelDefs_Label]?, viewer: ActorDefs_ViewerState?) {
            self.avatar = avatar
            self.description = description
            self.did = did
            self.displayName = displayName
            self.handle = handle
            self.indexedAt = indexedAt
            self.labels = labels
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case description
            case did
            case displayName
            case handle
            case indexedAt
            case labels
            case viewer
        }
    }
    class ActorDefs_ProfileViewBasic: Codable {
        let type = "app.bsky.actor.defs#profileViewBasic"
        var avatar: String?
        var did: String
        var displayName: String?
        var handle: String
        var labels: [comatprototypes.LabelDefs_Label]?
        var viewer: ActorDefs_ViewerState?
        init(avatar: String?, did: String, displayName: String?, handle: String, labels: [comatprototypes.LabelDefs_Label]?, viewer: ActorDefs_ViewerState?) {
            self.avatar = avatar
            self.did = did
            self.displayName = displayName
            self.handle = handle
            self.labels = labels
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case did
            case displayName
            case handle
            case labels
            case viewer
        }
    }
    class ActorDefs_ProfileViewDetailed: Codable {
        let type = "app.bsky.actor.defs#profileViewDetailed"
        var avatar: String?
        var banner: String?
        var description: String?
        var did: String
        var displayName: String?
        var followersCount: Int?
        var followsCount: Int?
        var handle: String
        var indexedAt: String?
        var labels: [comatprototypes.LabelDefs_Label]?
        var postsCount: Int?
        var viewer: ActorDefs_ViewerState?
        init(avatar: String?, banner: String?, description: String?, did: String, displayName: String?, followersCount: Int?, followsCount: Int?, handle: String, indexedAt: String?, labels: [comatprototypes.LabelDefs_Label]?, postsCount: Int?, viewer: ActorDefs_ViewerState?) {
            self.avatar = avatar
            self.banner = banner
            self.description = description
            self.did = did
            self.displayName = displayName
            self.followersCount = followersCount
            self.followsCount = followsCount
            self.handle = handle
            self.indexedAt = indexedAt
            self.labels = labels
            self.postsCount = postsCount
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case banner
            case description
            case did
            case displayName
            case followersCount
            case followsCount
            case handle
            case indexedAt
            case labels
            case postsCount
            case viewer
        }
    }
    class ActorDefs_SavedFeedsPref: Codable {
        let type = "app.bsky.actor.defs#savedFeedsPref"
        var pinned: [String]
        var saved: [String]
        init(pinned: [String], saved: [String]) {
            self.pinned = pinned
            self.saved = saved
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case pinned
            case saved
        }
    }
    class ActorDefs_ThreadViewPref: Codable {
        let type = "app.bsky.actor.defs#threadViewPref"
        var prioritizeFollowedUsers: Bool?
        var sort: String?
        init(prioritizeFollowedUsers: Bool?, sort: String?) {
            self.prioritizeFollowedUsers = prioritizeFollowedUsers
            self.sort = sort
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case prioritizeFollowedUsers
            case sort
        }
    }
    class ActorDefs_ViewerState: Codable {
        let type = "app.bsky.actor.defs#viewerState"
        var blockedBy: Bool?
        var blocking: String?
        var blockingByList: GraphDefs_ListViewBasic?
        var followedBy: String?
        var following: String?
        var muted: Bool?
        var mutedByList: GraphDefs_ListViewBasic?
        init(blockedBy: Bool?, blocking: String?, blockingByList: GraphDefs_ListViewBasic?, followedBy: String?, following: String?, muted: Bool?, mutedByList: GraphDefs_ListViewBasic?) {
            self.blockedBy = blockedBy
            self.blocking = blocking
            self.blockingByList = blockingByList
            self.followedBy = followedBy
            self.following = following
            self.muted = muted
            self.mutedByList = mutedByList
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blockedBy
            case blocking
            case blockingByList
            case followedBy
            case following
            case muted
            case mutedByList
        }
    }
}