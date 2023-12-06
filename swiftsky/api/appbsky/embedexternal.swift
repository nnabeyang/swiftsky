import SwiftAtproto
import Foundation
extension appbskytypes {
    class EmbedExternal: Codable {
        let type = "app.bsky.embed.external"
        var external: EmbedExternal_External
        init(external: EmbedExternal_External) {
            self.external = external
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case external
        }
    }
    class EmbedExternal_External: Codable {
        let type = "app.bsky.embed.external#external"
        var description: String
        var thumb: LexBlob?
        var title: String
        var uri: String
        init(description: String, thumb: LexBlob?, title: String, uri: String) {
            self.description = description
            self.thumb = thumb
            self.title = title
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case description
            case thumb
            case title
            case uri
        }
    }
    class EmbedExternal_View: Codable {
        let type = "app.bsky.embed.external#view"
        var external: EmbedExternal_ViewExternal
        init(external: EmbedExternal_ViewExternal) {
            self.external = external
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case external
        }
    }
    class EmbedExternal_ViewExternal: Codable {
        let type = "app.bsky.embed.external#viewExternal"
        var description: String
        var thumb: String?
        var title: String
        var uri: String
        init(description: String, thumb: String?, title: String, uri: String) {
            self.description = description
            self.thumb = thumb
            self.title = title
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case description
            case thumb
            case title
            case uri
        }
    }
}