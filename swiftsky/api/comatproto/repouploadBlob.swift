import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoUploadBlob_Output: Codable {
        let type = "com.atproto.repo.uploadBlob"
        var blob: LexBlob
        init(blob: LexBlob) {
            self.blob = blob
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blob
        }
    }
    static func RepoUploadBlob(input: Data) async throws -> RepoUploadBlob_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.uploadBlob", contentType: "*/*", httpMethod: .post, params: params, input: input)
    }
}