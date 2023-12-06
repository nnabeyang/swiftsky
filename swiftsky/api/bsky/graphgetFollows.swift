//
//  graphgetFollows.swift
//  swiftsky
//

struct graphGetFollowsInput: Encodable {
    let cursor: String?
    let limit: Int
    let actor: String
}

struct graphGetFollowsOutput: Decodable {
    var cursor: String?
    var follows: [ActorDefsProfileViewBasic]
    let subject: ActorDefsProfileViewBasic
}

func graphGetFollows(actor: String, limit: Int = 30, cursor: String? = nil) async throws -> graphGetFollowsOutput {
    try await Client.shared.fetch(
        endpoint: "app.bsky.graph.getFollows", authorization: Client.shared.user.accessJwt,
        params: graphGetFollowsInput(cursor: cursor, limit: limit, actor: actor)
    )
}
