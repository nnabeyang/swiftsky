import SwiftAtproto
import Foundation
extension comatprototypes {
    static func TempImportRepo(input: Data, did: String) async throws -> String {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.temp.importRepo", contentType: "*/*", httpMethod: .post, params: params, input: input)
    }
}