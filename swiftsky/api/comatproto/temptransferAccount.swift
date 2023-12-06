import SwiftAtproto
import Foundation
extension comatprototypes {
    class TempTransferAccount_Input: Codable {
        let type = "com.atproto.temp.transferAccount"
        var did: String
        var handle: String
        var plcOp: LexiconTypeDecoder
        init(did: String, handle: String, plcOp: LexiconTypeDecoder) {
            self.did = did
            self.handle = handle
            self.plcOp = plcOp
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case handle
            case plcOp
        }
    }
    class TempTransferAccount_Output: Codable {
        let type = "com.atproto.temp.transferAccount"
        var accessJwt: String
        var did: String
        var handle: String
        var refreshJwt: String
        init(accessJwt: String, did: String, handle: String, refreshJwt: String) {
            self.accessJwt = accessJwt
            self.did = did
            self.handle = handle
            self.refreshJwt = refreshJwt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case accessJwt
            case did
            case handle
            case refreshJwt
        }
    }
    static func TempTransferAccount(input: TempTransferAccount_Input) async throws -> TempTransferAccount_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.temp.transferAccount", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}