//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class FeedGetPostThread_Output: Codable {
        let type = "app.bsky.feed.getPostThread"
        var thread: FeedGetPostThread_Output_Thread

        init(thread: FeedGetPostThread_Output_Thread) {
            self.thread = thread
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case thread
        }
    }

    enum FeedGetPostThread_Output_Thread: Codable {
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

    static func FeedGetPostThread(depth: Int?, parentHeight: Int?, uri: String) async throws -> FeedGetPostThread_Output {
        let params: Parameters = ["depth": .integer(depth), "parentHeight": .integer(parentHeight), "uri": .string(uri)]
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.feed.getPostThread", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}
