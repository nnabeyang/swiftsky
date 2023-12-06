//
//  sessioncreate.swift
//  swiftsky
//

struct ServerCreateSessionInput: Encodable {
    let identifier: String
    let password: String
}

struct ServerCreateSessionOutput: Decodable, Hashable {
    let accessJwt: String
    let did: String
    let handle: String
    let refreshJwt: String
}

func ServerCreateSession(identifier: String, password: String) async throws -> ServerCreateSessionOutput {
    try await Client.shared.fetch(
        endpoint: "com.atproto.server.createSession", httpMethod: .post,
        params: ServerCreateSessionInput(identifier: identifier, password: password)
    )
}
