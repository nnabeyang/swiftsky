//
//  EmbedPostView.swift
//  swiftsky
//

import SwiftUI

struct EmbedPostView: View {
    @State var embedrecord: appbskytypes.EmbedRecord_View_Record
    @State var usernamehover: Bool = false
    @Binding var path: [Navigation]
    var markdown: String {
        var markdown = String()
        switch embedrecord {
        case let .embedRecordViewRecord(record):
            if let feed = record.value.val as? appbskytypes.FeedPost {
                let rt = RichText(text: feed.text, facets: feed.facets)
                for segment in rt.segments() {
                    if let link = segment.link() {
                        markdown += "[\(segment.text)](\(link))"
                    } else if let mention = segment.mention() {
                        markdown += "[\(segment.text)](swiftsky://profile?did=\(mention))"
                    } else {
                        markdown += segment.text
                    }
                }
            }
        default:
            break
        }
        return markdown
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity)
                .opacity(0.02)

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    if case let .embedRecordViewRecord(record) = embedrecord {
                        AvatarView(url: record.author.avatar, size: 16)
                        let displayname = record.author.displayName ?? record.author.handle

                        Button {
                            path.append(.profile(record.author.did))
                        } label: {
                            Text("\(displayname) \(Text(record.author.handle).foregroundColor(.secondary))")
                                .fontWeight(.semibold)
                                .underline(usernamehover)
                        }
                        .buttonStyle(.plain)
                        .hoverHand { usernamehover = $0 }
                        .tooltip {
                            ProfilePreview(did: record.author.did, path: $path)
                        }
                        Text(
                            Formatter.relativeDateNamed.localizedString(
                                fromTimeInterval: ISO8601DateFormatter(.withFractionalSeconds).date(from: record.indexedAt)?.timeIntervalSinceNow ?? 0)
                        )
                        .foregroundColor(.secondary)
                    }
                }

                Text(.init(markdown))
                if case let .embedRecordViewRecord(record) = embedrecord, let embeds = record.embeds {
                    ForEach(embeds) {
                        switch $0 {
                        case let .embedExternalView(embed):
                            EmbedExternalView(record: embed.external)
                        case let .embedImagesView(embed):
                            let images = embed.images
                            HStack {
                                ForEach(images) { image in
                                    Button {
                                        GlobalViewModel.shared.preview = URL(string: image.fullsize)
                                    } label: {
                                        let imagewidth = 600.0 / Double(images.count)
                                        let imageheight = 600.0 / Double(images.count)
                                        AsyncImage(url: URL(string: image.thumb)) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: imagewidth, maxHeight: imageheight, alignment: .topLeading)
                                                .clipped()

                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: imagewidth, height: imageheight)
                                        }
                                        .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                        .cornerRadius(15)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        case .embedRecordView, .embedRecordWithMediaView:
                            EmptyView()
                        }
                    }
                }
            }
            .padding(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.bottom, 5)
    }
}
