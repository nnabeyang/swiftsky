//
//  feedgetPostThread.swift
//  swiftsky
//

import Foundation

class FeedGetPostThreadThreadViewPost: Decodable, Hashable, Identifiable {
    static func == (lhs: FeedGetPostThreadThreadViewPost, rhs: FeedGetPostThreadThreadViewPost)
        -> Bool
    {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
    let type: String?
    let post: FeedDefsPostView?
    let parent: FeedGetPostThreadThreadViewPost?
    let replies: [FeedGetPostThreadThreadViewPost]?
    let notfound: Bool
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case post
        case parent
        case replies
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        post = try container.decodeIfPresent(FeedDefsPostView.self, forKey: .post)
        parent = decoder.codingPath.count < 100 ? try container.decodeIfPresent(FeedGetPostThreadThreadViewPost.self, forKey: .parent) : nil
        replies = try container.decodeIfPresent([FeedGetPostThreadThreadViewPost].self, forKey: .replies)
        notfound = type == "app.bsky.feed.defs#notFoundPost"
    }
}

struct FeedGetPostThreadInput: Encodable, Hashable {
    let uri: String
}

struct FeedGetPostThreadOutput: Decodable, Hashable {
    let thread: FeedGetPostThreadThreadViewPost?
}

func getPostThread(uri: String) async throws -> FeedGetPostThreadOutput {
    try await Client.shared.fetch(
        endpoint: "app.bsky.feed.getPostThread", authorization: Client.shared.user.accessJwt,
        params: FeedGetPostThreadInput(uri: uri)
    )
}
