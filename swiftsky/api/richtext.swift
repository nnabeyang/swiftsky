//
//  richtext.swift
//  swiftsky
//

import Foundation

struct RichTextSegment: Identifiable {
    let id = UUID()
    let text: String
    var facet: RichtextFacet? = nil

    func link() -> String? {
        facet?.features.first(where: { $0.uri != nil })?.uri
    }

    func mention() -> String? {
        facet?.features.first(where: { $0.did != nil })?.did
    }
}

struct RichText {
    let text: String
    let facets: [RichtextFacet]?
    func detectFacets() async -> [RichtextFacet] {
        var facets: [RichtextFacet] = []
        let mentionmatches = try? NSRegularExpression(pattern: "(^|\\s|\\()(@)([a-zA-Z0-9.-]+)(\\b)", options: [])
            .matches(in: text, range: NSRange(location: 0, length: text.utf16.count))
        let urlmatches = try? NSRegularExpression(pattern: "(^|\\s|\\()((https?:\\/\\/[\\S]+)|((?<domain>[a-z][a-z0-9]*(\\.[a-z0-9]+)+)[\\S]*))", options: [])
            .matches(in: text, range: NSRange(location: 0, length: text.utf16.count))
        if let urlmatches {
            for match in urlmatches {
                if let range = Range(match.range(at: 2), in: text) {
                    var url = text[range]
                    if !url.starts(with: "http") {
                        url = "https://\(url)"
                    }
                    let facet = RichtextFacet(features: [RichtextFacetFeatures(type: "app.bsky.richtext.facet#link", uri: String(url))], index: RichtextFacetByteSlice(byteEnd: text.utf8.distance(from: text.startIndex, to: range.upperBound), byteStart: text.utf8.distance(from: text.startIndex, to: range.lowerBound)))
                    facets.append(facet)
                }
            }
        }

        if let mentionmatches {
            for match in mentionmatches {
                if let range = Range(match.range(at: 3), in: text) {
                    let handle = text[range]
                    guard let did = try? await IdentityResolveHandle(handle: String(handle)) else {
                        continue
                    }
                    let facet = RichtextFacet(features: [RichtextFacetFeatures(type: "app.bsky.richtext.facet#mention", did: did.did)], index: RichtextFacetByteSlice(byteEnd: text.utf8.distance(from: text.startIndex, to: range.upperBound), byteStart: text.utf8.distance(from: text.startIndex, to: range.lowerBound) - 1))
                    facets.append(facet)
                }
            }
        }
        return facets
    }

    func segments() -> [RichTextSegment] {
        var segments: [RichTextSegment] = []
        var facets = facets ?? []
        if facets.isEmpty {
            segments.append(RichTextSegment(text: text))
            return segments
        }
        facets.sort()
        var textCursor = 0
        var facetCursor = 0
        repeat {
            let currFacet = facets[facetCursor]
            if textCursor < currFacet.index.byteStart {
                segments.append(RichTextSegment(text: text[textCursor ..< currFacet.index.byteStart]))
            } else if textCursor > currFacet.index.byteStart {
                facetCursor += 1
                continue
            }
            if currFacet.index.byteStart < currFacet.index.byteEnd {
                let subtext = text[currFacet.index.byteStart ..< currFacet.index.byteEnd]
                segments.append(RichTextSegment(text: subtext, facet: currFacet))
            }
            textCursor = currFacet.index.byteEnd
            facetCursor += 1
        } while facetCursor < facets.count
        if textCursor < text.utf8.count {
            segments.append(RichTextSegment(text: text[textCursor ..< text.utf8.count]))
        }
        return segments
    }
}
