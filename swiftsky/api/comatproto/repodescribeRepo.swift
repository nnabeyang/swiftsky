import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoDescribeRepo_Output: Codable {
        let type = "com.atproto.repo.describeRepo"
        var collections: [String]
        var did: String
        var didDoc: LexiconTypeDecoder
        var handle: String
        var handleIsCorrect: Bool
        init(collections: [String], did: String, didDoc: LexiconTypeDecoder, handle: String, handleIsCorrect: Bool) {
            self.collections = collections
            self.did = did
            self.didDoc = didDoc
            self.handle = handle
            self.handleIsCorrect = handleIsCorrect
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collections
            case did
            case didDoc
            case handle
            case handleIsCorrect
        }
    }
    static func RepoDescribeRepo(repo: String) async throws -> RepoDescribeRepo_Output {
        let params: Parameters = ["repo": .string(repo)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.describeRepo", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}