import SwiftAtproto
import Foundation
extension comatprototypes {
    static func TempPushBlob(input: Data, did: String) async throws -> Bool {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.temp.pushBlob", contentType: "*/*", httpMethod: .post, params: params, input: input)
    }
}