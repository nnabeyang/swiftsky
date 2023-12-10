//
//  PostView.swift
//  swiftsky
//

import QuickLook
import SwiftUI

struct PostView: View {
    @State var post: appbskytypes.FeedDefs_PostView
    @State var reply: String?
    @State var usernamehover: Bool = false
    @State var repost: appbskytypes.FeedDefs_ReasonRepost?
    @State var deletepostfailed = false
    @State var deletepost = false
    @State var underlinereply = false
    @State var translateavailable = false
    @StateObject var translateviewmodel = TranslateViewModel()
    @Binding var path: [Navigation]
    func delete() {
        Task {
            do {
                let result = try await comatprototypes.RepoDeleteRecord(client: XRPCClient.shared, input: .init(
                    collection: "app.bsky.feed.post",
                    repo: XRPCClient.shared.auth.did,
                    rkey: AtUri(uri: post.uri).rkey,
                    swapCommit: nil,
                    swapRecord: nil
                ))
                if result {}
            } catch {
                deletepostfailed = true
            }
        }
    }

    var markdown: String {
        var markdown = String()
        guard let record = post.record.val as? appbskytypes.FeedPost else { return "" }
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
        HStack(alignment: .top, spacing: 12) {
            AvatarView(url: post.author.avatar, size: 40)
            VStack(alignment: .leading, spacing: 2) {
                if let repost {
                    Text(
                        "\(Image(systemName: "arrow.triangle.2.circlepath")) Reposted by \(repost.by.handle)"
                    )
                    .foregroundColor(.secondary)
                }
                HStack(alignment: .firstTextBaseline) {
                    let displayname = post.author.displayName ?? post.author.handle

                    Button {
                        path.append(.profile(post.author.did))
                    } label: {
                        Text("\(displayname) \(Text(post.author.handle).foregroundColor(.secondary))")
                            .fontWeight(.semibold)
                            .underline(usernamehover)
                    }
                    .buttonStyle(.plain)
                    .hoverHand { usernamehover = $0 }
                    .tooltip {
                        ProfilePreview(did: post.author.did, path: $path)
                    }
                    Text(
                        Formatter.relativeDateNamed.localizedString(
                            fromTimeInterval: ISO8601DateFormatter(.withFractionalSeconds).date(from: post.indexedAt)?.timeIntervalSinceNow ?? 0)
                    )
                    .font(.body)
                    .foregroundColor(.secondary)
                    .help(ISO8601DateFormatter(.withFractionalSeconds).date(from: post.indexedAt)?.formatted(date: .complete, time: .standard) ?? "")

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
                        .hoverHand()
                    }
                    .frame(height: 0)
                }
                if let reply {
                    HStack(spacing: 0) {
                        Text("Reply to ").foregroundColor(.secondary)
                        Button {
                            path.append(.profile(reply))
                        } label: {
                            Text("@\(reply)").foregroundColor(Color(.linkColor))
                                .underline(underlinereply)
                                .hoverHand {
                                    underlinereply = $0
                                }
                                .tooltip {
                                    ProfilePreview(did: reply, path: $path)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                if !((post.record.val as? appbskytypes.FeedPost)?.text ?? "").isEmpty {
                    let padding: CGFloat = switch post.embed {
                    case .embedImagesView:
                        0
                    default:
                        translateavailable ? 0 : 6
                    }
                    Text(.init(markdown))
                        .textSelection(.enabled)
                        .padding(.bottom, padding)
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
                                    let imagewidth = 500.0 / Double(images.count)
                                    let imageheight = 500.0 / Double(images.count)
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
                        EmbedPostView(embedrecord: embed.record, path: $path)
                            .onTapGesture {
                                switch embed.record {
                                case let .embedRecordViewRecord(record):
                                    path.append(.thread(record.uri))
                                default:
                                    break
                                }
                            }
                    case let .embedExternalView(embed):
                        EmbedExternalView(record: embed.external)
                    case .embedRecordWithMediaView:
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            guard let feedPost = post.record.val as? appbskytypes.FeedPost else { return }
            if translateviewmodel.text.isEmpty, !feedPost.text.isEmpty {
                if feedPost.text.languageCode != GlobalViewModel.shared.systemLanguageCode {
                    translateavailable = true
                }
                translateviewmodel.text = feedPost.text
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
