//
//  repocreateRecord.swift
//  swiftsky
//

import Foundation

struct RepoCreateRecordOutput: Decodable {
    let cid: String
    let uri: String
}

struct LikePostInput: Encodable {
    let subject: RepoStrongRef
    let createdAt: String
}

struct RepostPostInput: Encodable {
    let subject: RepoStrongRef
    let createdAt: String
}

struct FollowUserInput: Encodable {
    let subject: String
    let createdAt: String
}

struct EmbedRefRecord: Encodable {
    let type = "app.bsky.embed.record"
    let record: RepoStrongRef
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case record
    }

    init(cid: String, uri: String) {
        record = RepoStrongRef(cid: cid, uri: uri)
    }
}

struct EmbedRefImage: Encodable {
    let type = "app.bsky.embed.images"
    let images: [EmbedImagesImage]
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case images
    }
}

struct EmbedRefRecordWithMedia: Encodable {
    let type = "app.bsky.embed.recordWithMedia"
    let record: EmbedRefRecord
    let media: EmbedRefImage
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case record
        case media
    }
}

struct EmbedRef: Encodable {
    let record: EmbedRefRecord?
    let images: EmbedRefImage?
    init(record: EmbedRefRecord? = nil, images: EmbedRefImage? = nil) {
        self.record = record
        self.images = images
    }

    func isValid() -> Bool {
        record != nil || images != nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let record, let images {
            try container.encode(EmbedRefRecordWithMedia(record: record, media: images))
        } else if let record {
            try container.encode(record)
        } else if let images {
            try container.encode(images)
        }
    }
}

struct CreatePostInput: Encodable {
    let text: String
    let createdAt: String
    let embed: EmbedRef?
    let reply: FeedPostReplyRef?
    let facets: [RichtextFacet]?
}

struct RepoCreateRecordInput<T: Encodable>: Encodable {
    let type: String
    let collection: String
    let repo: String
    let record: T
    enum CodingKeys: String, CodingKey {
        case type = "$type"
        case collection
        case repo
        case record
    }
}

func repoCreateRecord(input: RepoCreateRecordInput<some Encodable>) async throws
    -> RepoCreateRecordOutput
{
    try await Client.shared.fetch(
        endpoint: "com.atproto.repo.createRecord", httpMethod: .post,
        authorization: Client.shared.user.accessJwt, params: input
    )
}

func followUser(did: String) async throws -> RepoCreateRecordOutput {
    try await repoCreateRecord(
        input: RepoCreateRecordInput(
            type: "app.bsky.graph.follow", collection: "app.bsky.graph.follow",
            repo: Client.shared.did,
            record: FollowUserInput(
                subject: did,
                createdAt: Date().iso8601withFractionalSeconds
            )
        ))
}

func blockUser(did: String) async throws -> RepoCreateRecordOutput {
    try await repoCreateRecord(
        input: RepoCreateRecordInput(
            type: "app.bsky.graph.block", collection: "app.bsky.graph.block",
            repo: Client.shared.did,
            record: ["subject": did, "createdAt": Date().iso8601withFractionalSeconds, "$type": "app.bsky.graph.block"]
        ))
}

func makePost(text: String, reply: FeedPostReplyRef? = nil, facets: [RichtextFacet]? = nil, embed: EmbedRef? = nil) async throws -> RepoCreateRecordOutput {
    try await repoCreateRecord(
        input: RepoCreateRecordInput(
            type: "app.bsky.feed.post", collection: "app.bsky.feed.post", repo: Client.shared.did,
            record: CreatePostInput(
                text: text, createdAt: Date().iso8601withFractionalSeconds, embed: embed, reply: reply, facets: facets
            )
        ))
}

func likePost(uri: String, cid: String) async throws -> RepoCreateRecordOutput {
    try await repoCreateRecord(
        input: RepoCreateRecordInput(
            type: "app.bsky.feed.like", collection: "app.bsky.feed.like", repo: Client.shared.did,
            record: LikePostInput(
                subject: RepoStrongRef(cid: cid, uri: uri), createdAt: Date().iso8601withFractionalSeconds
            )
        ))
}

func RepostPost(uri: String, cid: String) async throws -> RepoCreateRecordOutput {
    try await repoCreateRecord(
        input: RepoCreateRecordInput(
            type: "app.bsky.feed.repost", collection: "app.bsky.feed.repost", repo: Client.shared.did,
            record: RepostPostInput(
                subject: RepoStrongRef(cid: cid, uri: uri), createdAt: Date().iso8601withFractionalSeconds
            )
        ))
}
