import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncRequestCrawl_Input: Codable {
        let type = "com.atproto.sync.requestCrawl"
        var hostname: String
        init(hostname: String) {
            self.hostname = hostname
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case hostname
        }
    }
    static func SyncRequestCrawl(input: SyncRequestCrawl_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.requestCrawl", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}