//
//  getPopularFeedGenerators.swift
//  swiftsky
//

struct getPopularFeedGeneratorsOutput: Decodable {
    let feeds: [FeedDefsGeneratorView]
}

func getPopularFeedGenerators() async throws -> getPopularFeedGeneratorsOutput {
    try await Client.shared.fetch(
        endpoint: "app.bsky.unspecced.getPopularFeedGenerators", authorization: Client.shared.user.accessJwt,
        params: Bool?.none
    )
}
