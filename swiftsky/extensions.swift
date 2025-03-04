//
//  extensions.swift
//  swiftsky
//

import Foundation
import NaturalLanguage
import SwiftUI

extension View {
    func hoverHand(callback: ((Bool) -> Void)? = nil) -> some View {
        onHover {
            if $0 {
                NSCursor.pointingHand.push()
            } else {
                NSCursor.pop()
            }
            callback?($0)
        }
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension RelativeDateTimeFormatter {
    convenience init(_ dateTimeStyle: DateTimeStyle) {
        self.init()
        self.dateTimeStyle = dateTimeStyle
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([
        .withInternetDateTime, .withFractionalSeconds,
    ])
    static let iso8601withTimeZone = ISO8601DateFormatter([.withInternetDateTime, .withTimeZone])
    static let relativeDateNamed = RelativeDateTimeFormatter(.named)
}

extension Date {
    var iso8601withFractionalSeconds: String {
        Formatter.iso8601withFractionalSeconds.string(from: self)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Locale {
    static var preferredLanguageCodes: [String] {
        Locale.preferredLanguages.compactMap {
            Locale(identifier: $0).language.languageCode?.identifier
        }
    }
}

extension String {
    var languageCode: String {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(self)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return "" }
        return languageCode
    }
}

class NSAction<T>: NSObject {
    let action: (T) -> Void

    init(_ action: @escaping (T) -> Void) {
        self.action = action
    }

    @objc func invoke(sender: AnyObject) {
        action(sender as! T)
    }
}

extension NSButton {
    func setAction(_ closure: @escaping (NSButton) -> Void) {
        let action = NSAction<NSButton>(closure)
        target = action
        self.action = #selector(NSAction<NSButton>.invoke)
        objc_setAssociatedObject(
            self, "\(hashValue)", action, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
}

extension NSMenuItem {
    func setAction(_ closure: @escaping (NSMenuItem) -> Void) {
        let action = NSAction<NSMenuItem>(closure)
        target = action
        self.action = #selector(NSAction<NSMenuItem>.invoke)
        objc_setAssociatedObject(
            self, "\(hashValue)", action, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap {
            $0 as? [String: Any]
        }
    }
}

extension String {
    subscript(bounds: CountableRange<Int>) -> String {
        if bounds.upperBound > utf8.count {
            return ""
        }
        let start = utf8.index(startIndex, offsetBy: bounds.lowerBound)
        let end = utf8.index(startIndex, offsetBy: bounds.upperBound)
        return String(utf8[start ..< end])!
    }
}

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
