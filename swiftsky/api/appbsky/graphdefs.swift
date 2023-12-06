import SwiftAtproto
import Foundation
extension appbskytypes {
    class GraphDefs_ListItemView: Codable {
        let type = "app.bsky.graph.defs#listItemView"
        var subject: ActorDefs_ProfileView
        var uri: String
        init(subject: ActorDefs_ProfileView, uri: String) {
            self.subject = subject
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case subject
            case uri
        }
    }
    class GraphDefs_ListView: Codable {
        let type = "app.bsky.graph.defs#listView"
        var avatar: String?
        var cid: String
        var creator: ActorDefs_ProfileView
        var description: String?
        var descriptionFacets: [RichtextFacet]?
        var indexedAt: String
        var name: String
        var purpose: String
        var uri: String
        var viewer: GraphDefs_ListViewerState?
        init(avatar: String?, cid: String, creator: ActorDefs_ProfileView, description: String?, descriptionFacets: [RichtextFacet]?, indexedAt: String, name: String, purpose: String, uri: String, viewer: GraphDefs_ListViewerState?) {
            self.avatar = avatar
            self.cid = cid
            self.creator = creator
            self.description = description
            self.descriptionFacets = descriptionFacets
            self.indexedAt = indexedAt
            self.name = name
            self.purpose = purpose
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
            case indexedAt
            case name
            case purpose
            case uri
            case viewer
        }
    }
    class GraphDefs_ListViewBasic: Codable {
        let type = "app.bsky.graph.defs#listViewBasic"
        var avatar: String?
        var cid: String
        var indexedAt: String?
        var name: String
        var purpose: String
        var uri: String
        var viewer: GraphDefs_ListViewerState?
        init(avatar: String?, cid: String, indexedAt: String?, name: String, purpose: String, uri: String, viewer: GraphDefs_ListViewerState?) {
            self.avatar = avatar
            self.cid = cid
            self.indexedAt = indexedAt
            self.name = name
            self.purpose = purpose
            self.uri = uri
            self.viewer = viewer
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case avatar
            case cid
            case indexedAt
            case name
            case purpose
            case uri
            case viewer
        }
    }
    class GraphDefs_ListViewerState: Codable {
        let type = "app.bsky.graph.defs#listViewerState"
        var blocked: String?
        var muted: Bool?
        init(blocked: String?, muted: Bool?) {
            self.blocked = blocked
            self.muted = muted
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blocked
            case muted
        }
    }
}