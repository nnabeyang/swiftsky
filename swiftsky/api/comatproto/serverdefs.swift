import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerDefs_InviteCode: Codable {
        let type = "com.atproto.server.defs#inviteCode"
        var available: Int
        var code: String
        var createdAt: String
        var createdBy: String
        var disabled: Bool
        var forAccount: String
        var uses: [ServerDefs_InviteCodeUse]
        init(available: Int, code: String, createdAt: String, createdBy: String, disabled: Bool, forAccount: String, uses: [ServerDefs_InviteCodeUse]) {
            self.available = available
            self.code = code
            self.createdAt = createdAt
            self.createdBy = createdBy
            self.disabled = disabled
            self.forAccount = forAccount
            self.uses = uses
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case available
            case code
            case createdAt
            case createdBy
            case disabled
            case forAccount
            case uses
        }
    }
    class ServerDefs_InviteCodeUse: Codable {
        let type = "com.atproto.server.defs#inviteCodeUse"
        var usedAt: String
        var usedBy: String
        init(usedAt: String, usedBy: String) {
            self.usedAt = usedAt
            self.usedBy = usedBy
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case usedAt
            case usedBy
        }
    }
}