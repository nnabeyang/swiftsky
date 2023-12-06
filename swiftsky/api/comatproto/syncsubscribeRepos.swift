import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncSubscribeRepos_Commit: Codable {
        let type = "com.atproto.sync.subscribeRepos#commit"
        var blobs: [LexLink]
        var blocks: Data
        var commit: LexLink
        var ops: [SyncSubscribeRepos_RepoOp]
        var prev: LexLink?
        var rebase: Bool
        var repo: String
        var rev: String
        var seq: Int
        var since: String
        var time: String
        var tooBig: Bool
        init(blobs: [LexLink], blocks: Data, commit: LexLink, ops: [SyncSubscribeRepos_RepoOp], prev: LexLink?, rebase: Bool, repo: String, rev: String, seq: Int, since: String, time: String, tooBig: Bool) {
            self.blobs = blobs
            self.blocks = blocks
            self.commit = commit
            self.ops = ops
            self.prev = prev
            self.rebase = rebase
            self.repo = repo
            self.rev = rev
            self.seq = seq
            self.since = since
            self.time = time
            self.tooBig = tooBig
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blobs
            case blocks
            case commit
            case ops
            case prev
            case rebase
            case repo
            case rev
            case seq
            case since
            case time
            case tooBig
        }
    }
    class SyncSubscribeRepos_Handle: Codable {
        let type = "com.atproto.sync.subscribeRepos#handle"
        var did: String
        var handle: String
        var seq: Int
        var time: String
        init(did: String, handle: String, seq: Int, time: String) {
            self.did = did
            self.handle = handle
            self.seq = seq
            self.time = time
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case handle
            case seq
            case time
        }
    }
    class SyncSubscribeRepos_Info: Codable {
        let type = "com.atproto.sync.subscribeRepos#info"
        var message: String?
        var name: String
        init(message: String?, name: String) {
            self.message = message
            self.name = name
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case message
            case name
        }
    }
    class SyncSubscribeRepos_Migrate: Codable {
        let type = "com.atproto.sync.subscribeRepos#migrate"
        var did: String
        var migrateTo: String
        var seq: Int
        var time: String
        init(did: String, migrateTo: String, seq: Int, time: String) {
            self.did = did
            self.migrateTo = migrateTo
            self.seq = seq
            self.time = time
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case migrateTo
            case seq
            case time
        }
    }
    class SyncSubscribeRepos_RepoOp: Codable {
        let type = "com.atproto.sync.subscribeRepos#repoOp"
        var action: String
        var cid: LexLink
        var path: String
        init(action: String, cid: LexLink, path: String) {
            self.action = action
            self.cid = cid
            self.path = path
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case action
            case cid
            case path
        }
    }
    class SyncSubscribeRepos_Tombstone: Codable {
        let type = "com.atproto.sync.subscribeRepos#tombstone"
        var did: String
        var seq: Int
        var time: String
        init(did: String, seq: Int, time: String) {
            self.did = did
            self.seq = seq
            self.time = time
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case seq
            case time
        }
    }
}