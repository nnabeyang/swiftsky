//
//  ThreadView.swift
//  swiftsky
//

import SwiftUI

struct ThreadView: View {
    var uri: String
    @State var error: String?
    @State var threadviewpost: FeedGetPostThreadThreadViewPost? = nil
    @State var parents: [FeedGetPostThreadThreadViewPost] = []
    @State var replypresented: Bool = false
    @Binding var path: [Navigation]
    @StateObject private var globalmodel = GlobalViewModel.shared
    func load() async {
        threadviewpost = nil
        parents = []
        do {
            let result = try await getPostThread(uri: uri)
            if let thread = result.thread {
                threadviewpost = thread
                var currentparent = thread.parent
                while let parent = currentparent {
                    parents.append(parent)
                    currentparent = parent.parent
                }
                parents.reverse()
            }
        } catch {
            if let error = error as? xrpcErrorDescription {
                self.error = error.message!
                return
            }
            self.error = error.localizedDescription
        }
    }

    var parentPosts: some View {
        ForEach(parents) { parent in
            if let parentpost = parent.post {
                PostView(post: parentpost, reply: parent.parent?.post?.author.handle, path: $path)
                    .padding([.top, .horizontal])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        path.append(.thread(parentpost.uri))
                    }
                PostFooterView(bottompadding: false, post: parentpost, path: $path)
            }
        }
    }

    var body: some View {
        ScrollViewReader { proxy in
            List {
                Group {
                    if let viewpost = threadviewpost?.post {
                        parentPosts
                            .background(alignment: .topLeading) {
                                Color(NSColor.quaternaryLabelColor)
                                    .frame(width: 4)
                                    .padding(.leading, 35)
                            }
                        ThreadPostview(
                            post: viewpost, reply: threadviewpost?.parent?.post?.author.handle, path: $path,
                            load: load
                        )
                        .padding(.horizontal)
                        .padding(.top, parents.isEmpty ? 0 : 5)
                        .background(alignment: .topLeading) {
                            if !parents.isEmpty {
                                Color(NSColor.quaternaryLabelColor)
                                    .frame(width: 4, height: 15)
                                    .padding(.leading, 35)
                            }
                        }
                        PostFooterView(leadingpadding: 15, post: viewpost, path: $path)
                        Divider()
                        HStack {
                            AvatarView(url: globalmodel.profile?.avatar, size: 40)
                                .padding(.leading)
                                .padding([.vertical, .trailing], 5)

                            Text("Reply to @\(viewpost.author.handle)")
                                .font(.system(size: 15))
                                .opacity(0.9)
                            Spacer()
                        }
                        .hoverHand()
                        .onTapGesture {
                            replypresented = true
                        }
                        Divider()
                            .id(viewpost.cid)
                        if let replies = threadviewpost?.replies {
                            ForEach(replies) { post in
                                if let post = post.post {
                                    PostView(post: post, reply: viewpost.author.handle, path: $path)
                                        .padding([.top, .horizontal])
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            path.append(.thread(post.uri))
                                        }
                                    PostFooterView(post: post, path: $path)
                                    Divider()
                                }
                            }
                        }
                    } else {
                        if error == nil {
                            ProgressView().frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .sheet(isPresented: $replypresented) {
                NewPostView(post: threadviewpost?.post)
                    .frame(width: 600)
                    .fixedSize()
            }
            .alert(error ?? "", isPresented: .constant(error != nil)) {
                Button("OK") {
                    path.removeLast()
                }
            }
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 1)
            .listStyle(.plain)
            .navigationTitle(
                threadviewpost?.post != nil ? "\(threadviewpost!.post!.author.handle)'s post" : "Post"
            )
            .task {
                await load()
                if let post = threadviewpost?.post {
                    DispatchQueue.main.async {
                        proxy.scrollTo(post.cid)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    if let post = threadviewpost?.post {
                        let uri = AtUri(uri: post.uri)
                        ShareLink(item: URL(string: "https://staging.bsky.app/profile/\(post.author.handle)/post/\(uri.rkey)")!)
                    }
                    Button {
                        Task {
                            await load()
                            if let post = threadviewpost?.post {
                                DispatchQueue.main.async {
                                    proxy.scrollTo(post.cid)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}
