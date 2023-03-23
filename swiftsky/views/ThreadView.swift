//
//  ThreadView.swift
//  swiftsky
//

import SwiftUI

struct SeparatorShape: Shape {
    var yoffset = 0.0
    var lastpost = false
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if lastpost {
            path.addRect(CGRect(x: rect.minX + 35, y: rect.minY + yoffset, width: 2, height: rect.maxY + 15))
        }
        else {
            path.addRect(CGRect(x: rect.minX + 35, y: rect.minY + yoffset, width: 2, height: rect.maxY - yoffset))
        }
        return path
    }
}
struct ThreadView: View {
    var uri: String
    @State var error: String?
    @State var threadviewpost: FeedGetPostThreadThreadViewPost? = nil
    @State var parents: [FeedGetPostThreadThreadViewPost] = []
    @Binding var compose: Bool
    @Binding var post: FeedPostView?
    @Binding var path: NavigationPath
    func load() {
        threadviewpost = nil
        parents = []
        getPostThread(uri: self.uri) { result in
            switch result {
            case .success(let result):
                if let thread = result.thread {
                    self.threadviewpost = thread
                    var currentparent = thread.parent
                    while let parent = currentparent {
                        parents.append(parent)
                        currentparent = parent.parent
                    }
                    parents.reverse()
                    return
                }
            case .failure(let fail):
                switch fail {
                case .APIError(let err):
                    error = err.message
                    return
                default:
                    break
                }
            }
            error = "Load post failed"
        }
    }
    var body: some View {
        List {
            Group {
                if let viewpost = threadviewpost?.post {
                    ForEach(parents) { parent in
                        ZStack {
                            SeparatorShape(yoffset: parent == parents.first ? 55 : 0, lastpost: parent == parents.last)
                                .foregroundColor(Color(nsColor: NSColor.quaternaryLabelColor))
                            VStack(spacing: 0) {
                                PostView(post: parent.post, reply: parent.parent?.post.author.handle, path: $path)
                                    .padding([.top,.horizontal])
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        path.append(parent.post)
                                    }
                                PostFooterView(bottompadding: false, post: parent.post)
                                    .padding(.leading, 67.0)
                            }
                        }
                    }
                    ThreadPostview(post: viewpost,reply: threadviewpost?.parent?.post.author.handle, path: $path, load: load)
                        .padding([.top, .horizontal])
                    PostFooterView(post: viewpost)
                        .padding(.leading, 17.0)
                    Divider()
                    HStack() {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.accentColor)
                            .frame(width: 40, height: 40)
                            .padding(.leading)
                            .padding([.vertical, .trailing], 5)
                        
                        Text("Reply to @\(viewpost.author.handle)")
                            .font(.system(size: 15))
                            .opacity(0.9)
                        Spacer()
                    }.onHover { ishovered in
                        if ishovered {
                            NSCursor.pointingHand.push()
                        }
                        else {
                            NSCursor.pointingHand.pop()
                        }
                    }
                    .onTapGesture {
                        compose = true
                        post = viewpost
                    }
                    Divider()
                    if let replies = threadviewpost?.replies {
                        ForEach(replies, id: \.self) { post in
                            HStack {
                                PostView(post: post.post,reply: viewpost.author.handle, path: $path)
                                    .padding([.top, .horizontal])
                                    .contentShape(Rectangle())
                            }
                            .onTapGesture {
                                path.append(post.post)
                            }
                            PostFooterView(post: post.post)
                                .padding(.leading, 67.0)
                            Divider()
                        }
                    }
                } else {
                    if error == nil {
                        ProgressView().frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }.listRowInsets(EdgeInsets())
        }
        .alert(error ?? "", isPresented: .constant(error != nil)) {
            Button("OK" ) {
                path.removeLast()
            }
        }
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 0.1)
        .listStyle(.plain)
        .navigationTitle(threadviewpost != nil ? "\(threadviewpost!.post.author.handle)'s post" : "Post")
        .onAppear {
            load()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    load()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
            }
        }
    }
}

