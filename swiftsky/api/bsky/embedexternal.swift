//
//  embedexternal.swift
//  swiftsky
//

struct EmbedExternalExternal: Decodable, Hashable {
    let description: String
    let thumb: LexBlob?
    let title: String
    let uri: String
}

struct EmbedExternalViewExternal: Decodable, Hashable {
    let description: String
    let thumb: String?
    let title: String
    let uri: String
}
