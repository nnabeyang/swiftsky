//
//  NewPostView.swift
//  swiftsky
//

import SwiftUI

struct ImageAttachment: Identifiable {
    let id = UUID()
    let image: Image
    let data: Data
}

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var disablebuttons: Bool = false
    @State private var isFilePickerPresented: Bool = false
    @State private var error: String?
    @State private var images: [ImageAttachment] = []
    @StateObject private var globalmodel = GlobalViewModel.shared
    var post: appbskytypes.FeedDefs_PostView?
    var isquote: Bool = false
    func makepost() {
        disablebuttons = true
        Task {
            do {
                var images = [appbskytypes.EmbedImages_Image]()
                for image in self.images {
                    let result = try await comatprototypes.RepoUploadBlob(client: XRPCClient.shared, input: image.data)
                    images.append(.init(alt: "", aspectRatio: nil, image: result.blob))
                }
                let embed: appbskytypes.FeedPost_Embed?
                if isquote {
                    embed = .embedRecord(.init(record: .init(cid: post!.cid, uri: post!.uri)))
                } else if !images.isEmpty {
                    embed = .embedImages(.init(images: images))
                } else {
                    embed = nil
                }
                var replyref: appbskytypes.FeedPost_ReplyRef? = nil
                if !isquote, let post, let record = post.record.val as? appbskytypes.FeedPost {
                    let parent = comatprototypes.RepoStrongRef(cid: post.cid, uri: post.uri)
                    let root: comatprototypes.RepoStrongRef
                    if let reply = record.reply {
                        root = comatprototypes.RepoStrongRef(cid: reply.root.cid, uri: reply.root.uri)
                    } else {
                        root = parent
                    }
                    replyref = appbskytypes.FeedPost_ReplyRef(parent: parent, root: root)
                }
                let rt = RichText(text: text, facets: nil)
                let facets = await rt.detectFacets()
                let _ = try await makePost(text: text, reply: replyref, facets: facets, embed: embed)
                dismiss()
            } catch {
                self.error = error.localizedDescription
            }
            disablebuttons = false
        }
    }

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.plain)
                .padding([.leading, .top], 20)
                .foregroundColor(.accentColor)
                .disabled(disablebuttons)
                Spacer()
                Button("Post") {
                    makepost()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .disabled(text.count > 300 || disablebuttons || (text.isEmpty && images.isEmpty))
                .padding([.trailing, .top], 20)
            }
            if let post {
                Divider().padding(.vertical, 5)
                HStack(alignment: .top, spacing: 12) {
                    AvatarView(url: post.author.avatar, size: 40)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.author.displayName ?? post.author.handle)
                            .fontWeight(.semibold)
                        Text((post.record.val as? appbskytypes.FeedPost)?.text ?? "")
                    }
                    Spacer()
                }
                .padding(.leading, 20)
            }
            Divider()
                .padding(.vertical, 5)
            HStack(alignment: .top) {
                AvatarView(url: globalmodel.profile?.avatar, size: 50)
                let placeholder = post != nil && !isquote ? "Reply to @\(post!.author.handle)" : "What's up?"
                VStack(alignment: .leading) {
                    TextViewWrapper(text: $text, placeholder: placeholder) {
                        if images.count >= 4 {
                            return
                        }
                        let imgData = NSPasteboard.general.data(forType: .png)
                        if let imgData {
                            DispatchQueue.main.async {
                                if let image = NSImage(data: imgData) {
                                    images.append(.init(image: Image(nsImage: image), data: imgData))
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Array(images.enumerated()), id: \.element.id) { index, image in
                                image.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipped()
                                    .overlay(alignment: .topTrailing) {
                                        Button {
                                            images.remove(at: index)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundStyle(
                                                    .secondary,
                                                    .clear,
                                                    .black
                                                )
                                                .padding(5)
                                        }
                                        .buttonStyle(.borderless)
                                        .font(.title)
                                    }
                            }
                        }
                    }
                }
            }
            .padding([.leading], 20)

            Divider()
                .padding(.vertical, 5)
            HStack {
                Button("\(Image(systemName: "photo"))") {
                    isFilePickerPresented.toggle()
                }
                .buttonStyle(.plain)
                .foregroundColor(.accentColor)
                .disabled(images.count >= 4)
                .font(.title)
                .padding(.leading)
                Spacer()
                let replycount = 300 - text.count
                Text("\(replycount)")
                    .padding(.trailing, 20)
                    .foregroundColor(replycount < 0 ? .red : .primary)
            }
            Spacer()
        }
        .fileImporter(isPresented: $isFilePickerPresented, allowedContentTypes: [.image], allowsMultipleSelection: true) { result in
            if let urls = try? result.get() {
                for url in urls {
                    if images.count >= 4 {
                        break
                    }
                    guard url.startAccessingSecurityScopedResource() else { continue }
                    if let data = try? Data(contentsOf: url) {
                        if let image = NSImage(data: data) {
                            images.append(.init(image: Image(nsImage: image), data: data))
                        }
                    }
                    url.stopAccessingSecurityScopedResource()
                }
            }
        }

        .alert("Error: \(error ?? "Unknown")", isPresented: .constant(error != nil)) {
            Button("OK") {
                error = nil
            }
        }
    }
}
