//
//  feedgetFeedGenerator.swift
//  swiftsky
//

struct FeedGetFeedGeneratorOutput: Decodable {
    let view: FeedDefsGeneratorView
    let isOnline: Bool
    let isValid: Bool
}

func FeedGetFeedGenerator(feed: String) async throws -> FeedGetFeedGeneratorOutput {
    try await Client.shared.fetch(
        endpoint: "app.bsky.feed.getFeedGenerator", authorization: Client.shared.user.accessJwt,
        params: ["feed": feed]
    )
}
