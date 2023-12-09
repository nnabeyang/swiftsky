//
//  ThreadPostView.swift
//  swiftsky
//

import QuickLook
import SwiftUI

struct ThreadPostview: View {
    @State var post: appbskytypes.FeedDefs_PostView
    @State var reply: String?
    @State var usernamehover: Bool = false
    @State var displaynamehover: Bool = false
    @State var deletepostfailed = false
    @State var deletepost = false
    @State var translateavailable = false
    @Binding var path: [Navigation]
    @StateObject var translateviewmodel = TranslateViewModel()
    var load: () async -> Void
    func delete() {
        Task {
            do {
                let result = try await comatprototypes.RepoDeleteRecord(input: .init(
                    collection: "app.bsky.feed.post",
                    repo: XRPCClient.shared.auth.did,
                    rkey: AtUri(uri: post.uri).rkey,
                    swapCommit: nil,
                    swapRecord: nil
                ))
                if result {
                    await load()
                }
            } catch {
                deletepostfailed = true
            }
        }
    }

    var markdown: String {
        guard let record = post.record.val as? appbskytypes.FeedPost else { return "" }
        var markdown = String()
        let rt = RichText(text: record.text, facets: record.facets)
        for segment in rt.segments() {
            if let link = segment.link() {
                markdown += "[\(segment.text)](\(link))"
            } else if let mention = segment.mention() {
                markdown += "[\(segment.text)](swiftsky://profile?did=\(mention))"
            } else {
                markdown += segment.text
            }
        }
        return markdown
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                AvatarView(url: post.author.avatar, size: 40)
                HStack(alignment: .firstTextBaseline) {
                    let displayname = post.author.displayName ?? post.author.handle
                    VStack(alignment: .leading) {
                        Button {
                            path.append(.profile(post.author.did))
                        } label: {
                            Text(displayname)
                                .fontWeight(.semibold)
                                .underline(usernamehover)
                        }
                        .buttonStyle(.plain)
                        .hoverHand { usernamehover = $0 }
                        .tooltip {
                            ProfilePreview(did: post.author.did, path: $path)
                        }
                        Button {
                            path.append(.profile(post.author.did))
                        } label: {
                            Text("@\(post.author.handle)")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                                .underline(displaynamehover)
                        }
                        .buttonStyle(.plain)
                        .onHover { ishovered in
                            if ishovered {
                                displaynamehover = true
                                NSCursor.pointingHand.push()
                            } else {
                                displaynamehover = false
                                NSCursor.pointingHand.pop()
                            }
                        }
                    }

                    Spacer()

                    Group {
                        MenuButton {
                            var items: [MenuItem] = []
                            items.append(
                                MenuItem(title: "Share") {
                                    print("Share")
                                })
                            items.append(
                                MenuItem(title: "Report") {
                                    print("Report")
                                })
                            if post.author.did == XRPCClient.shared.auth.did {
                                items.append(
                                    MenuItem(title: "Delete") {
                                        deletepost = true
                                    })
                            }
                            return items
                        }
                        .frame(width: 30, height: 30)
                        .contentShape(Rectangle())
                        .onHover { ishovered in
                            if ishovered {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pointingHand.pop()
                            }
                        }
                    }
                }
            }

            if !((post.record.val as? appbskytypes.FeedPost)?.text ?? "").isEmpty {
                Text(.init(markdown))
                    .foregroundColor(.primary)
                    .textSelection(.enabled)
                    .padding(.vertical, 4)
                if translateavailable {
                    TranslateView(viewmodel: translateviewmodel)
                }
            }
            if let embed = post.embed {
                switch embed {
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
                                .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                .cornerRadius(15)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                case let .embedRecordView(embed):
                    let record = embed.record
                    switch record {
                    case let .embedRecordViewRecord(viewRecord):
                        EmbedPostView(embedrecord: record, path: $path)
                            .onTapGesture {
                                path.append(.thread(viewRecord.uri))
                            }
                    default:
                        EmptyView()
                    }
                case let .embedExternalView(embed):
                    EmbedExternalView(record: embed.external)
                default:
                    EmptyView()
                }
            }
            Text({
                if let indexedAt = ISO8601DateFormatter(.withFractionalSeconds).date(from: post.indexedAt) {
                    "\(Text(indexedAt, style: .time)) · \(Text(indexedAt, style: .date))"
                } else {
                    post.indexedAt
                }
            }() as String)
                .foregroundColor(.secondary)
                .padding(.bottom, 6)
        }
        .onAppear {
            guard let postRecord = post.record.val as? appbskytypes.FeedPost else { return }
            if translateviewmodel.text.isEmpty, !postRecord.text.isEmpty {
                if postRecord.text.languageCode != GlobalViewModel.shared.systemLanguageCode {
                    translateavailable = true
                }
                translateviewmodel.text = postRecord.text
            }
        }
        .alert("Failed to delete post, please try again.", isPresented: $deletepostfailed, actions: {})
        .alert("Are you sure?", isPresented: $deletepost) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                delete()
            }
        }
    }
}
