import SwiftAtproto
import Foundation
extension appbskytypes {
    class EmbedImages: Codable {
        let type = "app.bsky.embed.images"
        var images: [EmbedImages_Image]
        init(images: [EmbedImages_Image]) {
            self.images = images
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case images
        }
    }
    class EmbedImages_AspectRatio: Codable {
        let type = "app.bsky.embed.images#aspectRatio"
        var height: Int
        var width: Int
        init(height: Int, width: Int) {
            self.height = height
            self.width = width
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case height
            case width
        }
    }
    class EmbedImages_Image: Codable {
        let type = "app.bsky.embed.images#image"
        var alt: String
        var aspectRatio: EmbedImages_AspectRatio?
        var image: LexBlob
        init(alt: String, aspectRatio: EmbedImages_AspectRatio?, image: LexBlob) {
            self.alt = alt
            self.aspectRatio = aspectRatio
            self.image = image
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case alt
            case aspectRatio
            case image
        }
    }
    class EmbedImages_View: Codable {
        let type = "app.bsky.embed.images#view"
        var images: [EmbedImages_ViewImage]
        init(images: [EmbedImages_ViewImage]) {
            self.images = images
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case images
        }
    }
    class EmbedImages_ViewImage: Codable {
        let type = "app.bsky.embed.images#viewImage"
        var alt: String
        var aspectRatio: EmbedImages_AspectRatio?
        var fullsize: String
        var thumb: String
        init(alt: String, aspectRatio: EmbedImages_AspectRatio?, fullsize: String, thumb: String) {
            self.alt = alt
            self.aspectRatio = aspectRatio
            self.fullsize = fullsize
            self.thumb = thumb
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case alt
            case aspectRatio
            case fullsize
            case thumb
        }
    }
}