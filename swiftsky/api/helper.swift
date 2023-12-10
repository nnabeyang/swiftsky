//
//  helper.swift
//  swiftsky
//

import Foundation
import SwiftAtproto

func followUser(did: String) async throws -> comatprototypes.RepoCreateRecord_Output {
    try await comatprototypes.RepoCreateRecord(
        client: XRPCClient.shared,
        input: .init(collection: "app.bsky.graph.follow",
                     record: LexiconTypeDecoder(
                         typeName: "app.bsky.graph.follow",
                         val: appbskytypes.GraphFollow(createdAt: Date().iso8601withFractionalSeconds, subject: did)
                     ),
                     repo: XRPCClient.shared.auth.did,
                     rkey: nil, swapCommit: nil, validate: nil)
    )
}

func blockUser(did: String) async throws -> comatprototypes.RepoCreateRecord_Output {
    try await comatprototypes.RepoCreateRecord(
        client: XRPCClient.shared,
        input: .init(collection: "app.bsky.graph.block",
                     record: LexiconTypeDecoder(
                         typeName: "app.bsky.graph.block",
                         val: appbskytypes.GraphBlock(createdAt: Date().iso8601withFractionalSeconds, subject: did)
                     ),
                     repo: XRPCClient.shared.auth.did,
                     rkey: nil, swapCommit: nil, validate: nil)
    )
}

func makePost(text: String, reply: appbskytypes.FeedPost_ReplyRef? = nil, facets: [appbskytypes.RichtextFacet]? = nil, embed: appbskytypes.FeedPost_Embed? = nil) async throws -> comatprototypes.RepoCreateRecord_Output {
    try await comatprototypes.RepoCreateRecord(
        client: XRPCClient.shared,
        input: .init(collection: "app.bsky.feed.post",
                     record: LexiconTypeDecoder(
                         typeName: "app.bsky.feed.post",
                         val: appbskytypes.FeedPost(
                             createdAt: Date().iso8601withFractionalSeconds,
                             embed: embed,
                             entities: nil,
                             facets: facets,
                             labels: nil,
                             langs: nil,
                             reply: reply,
                             tags: nil,
                             text: text
                         )
                     ),
                     repo: XRPCClient.shared.auth.did,
                     rkey: nil, swapCommit: nil, validate: nil)
    )
}

func likePost(uri: String, cid: String) async throws -> comatprototypes.RepoCreateRecord_Output {
    try await comatprototypes.RepoCreateRecord(
        client: XRPCClient.shared,
        input: .init(
            collection: "app.bsky.feed.like",
            record: LexiconTypeDecoder(
                typeName: "app.bsky.feed.like",
                val: appbskytypes.FeedLike(
                    createdAt: Date().iso8601withFractionalSeconds,
                    subject: .init(cid: cid, uri: uri)
                )
            ),
            repo: XRPCClient.shared.auth.did,
            rkey: nil, swapCommit: nil, validate: nil
        )
    )
}

func RepostPost(uri: String, cid: String) async throws -> comatprototypes.RepoCreateRecord_Output {
    try await comatprototypes.RepoCreateRecord(
        client: XRPCClient.shared,
        input: .init(
            collection: "app.bsky.feed.repost",
            record: LexiconTypeDecoder(
                typeName: "app.bsky.feed.repost",
                val: appbskytypes.FeedRepost(
                    createdAt: Date().iso8601withFractionalSeconds,
                    subject: .init(cid: cid, uri: uri)
                )
            ),
            repo: XRPCClient.shared.auth.did,
            rkey: nil, swapCommit: nil, validate: nil
        )
    )
}
