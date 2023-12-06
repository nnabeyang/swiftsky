enum appbskytypes {}

extension appbskytypes.FeedDefs_ThreadViewPost_Replies_Elem: Identifiable {
    var id: ObjectIdentifier {
        switch self {
        case let .feedDefsBlockedPost(v):
            v.id
        case let .feedDefsThreadViewPost(v):
            v.id
        case let .feedDefsNotFoundPost(v):
            v.id
        }
    }

    var post: appbskytypes.FeedDefs_PostView? {
        switch self {
        case let .feedDefsThreadViewPost(v): v.post
        default: nil
        }
    }
}

extension appbskytypes.FeedDefs_ReplyRef_Parent {
    var author: appbskytypes.ActorDefs_ProfileViewBasic? {
        switch self {
        case let .feedDefsPostView(view):
            view.author
        default:
            nil
        }
    }

    var post: appbskytypes.FeedDefs_PostView? {
        switch self {
        case let .feedDefsPostView(view):
            view
        default:
            nil
        }
    }
}

extension appbskytypes.FeedDefs_FeedViewPost_Reason {
    var repost: appbskytypes.FeedDefs_ReasonRepost {
        switch self {
        case let .feedDefsReasonRepost(repost):
            repost
        }
    }
}

extension appbskytypes.NotificationListNotifications_Notification: Identifiable {}
extension appbskytypes.ActorDefs_ProfileView: Identifiable {}
extension appbskytypes.ActorDefs_ProfileViewBasic: Identifiable {}
extension appbskytypes.FeedGetLikes_Like: Identifiable {}
extension appbskytypes.FeedDefs_NotFoundPost: Identifiable {}
extension appbskytypes.FeedDefs_BlockedPost: Identifiable {}
extension appbskytypes.FeedDefs_ThreadViewPost: Identifiable {}
extension appbskytypes.FeedDefs_FeedViewPost: Identifiable {}
extension appbskytypes.EmbedImages_ViewImage: Identifiable {}
extension appbskytypes.FeedDefs_GeneratorView: Identifiable {}
extension appbskytypes.EmbedImages_View: Identifiable {}
extension appbskytypes.EmbedExternal_View: Identifiable {}
extension appbskytypes.EmbedRecord_View: Identifiable {}
extension appbskytypes.EmbedRecordWithMedia_View: Identifiable {}
extension appbskytypes.EmbedRecord_ViewRecord_Embeds_Elem: Identifiable {
    var id: ObjectIdentifier {
        switch self {
        case let .embedExternalView(v):
            v.id
        case let .embedImagesView(v):
            v.id
        case let .embedRecordView(v):
            v.id
        case let .embedRecordWithMediaView(v):
            v.id
        }
    }
}

extension appbskytypes.FeedDefs_ThreadViewPost_Parent {
    var parent: appbskytypes.FeedDefs_ThreadViewPost_Parent? {
        switch self {
        case let .feedDefsThreadViewPost(thread): thread.parent
        default: nil
        }
    }

    var post: appbskytypes.FeedDefs_PostView? {
        switch self {
        case let .feedDefsThreadViewPost(thread): thread.post
        default: nil
        }
    }
}

extension appbskytypes.RichtextFacet_Features_Elem {
    var uri: String? {
        switch self {
        case let .richtextFacetLink(v): v.uri
        default: nil
        }
    }

    var did: String? {
        switch self {
        case let .richtextFacetMention(v): v.did
        case .richtextFacetTag: nil
        case .richtextFacetLink: nil
        }
    }
}

extension appbskytypes.RichtextFacet: Comparable {
    static func < (lhs: appbskytypes.RichtextFacet, rhs: appbskytypes.RichtextFacet) -> Bool {
        lhs.index.byteStart < rhs.index.byteStart
    }

    static func == (lhs: appbskytypes.RichtextFacet, rhs: appbskytypes.RichtextFacet) -> Bool {
        lhs.index.byteStart == rhs.index.byteStart
    }
}
