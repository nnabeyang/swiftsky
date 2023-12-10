//
//  LoginView.swift
//  swiftsky
//

import SwiftUI
struct LoginView: View {
    @State private var handle: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var isButtonDisabled: Bool = false
    @StateObject private var auth = Auth.shared
    private func signin() {
        Task {
            isButtonDisabled = true
            do {
                let result = try await comatprototypes.ServerCreateSession(client: XRPCClient.shared,
                                                                           input: .init(identifier: handle, password: password))
                XRPCClient.shared.auth.refreshJwt = result.refreshJwt
                XRPCClient.shared.auth.accessJwt = result.accessJwt
                XRPCClient.shared.auth.handle = result.handle
                XRPCClient.shared.auth.did = result.did
                XRPCClient.shared.auth.save()
                DispatchQueue.main.async {
                    auth.needAuthorization = false
                }
            } catch {
                self.error = error.localizedDescription
            }
            isButtonDisabled = false
        }
    }

    var body: some View {
        Form {
            Section {
                LabeledContent("Handle or email address") {
                    TextField("Handle", text: $handle)
                        .textContentType(.username)
                        .multilineTextAlignment(.trailing)
                        .labelsHidden()
                }
                LabeledContent("App password") {
                    SecureField("Password", text: $password)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.trailing)
                        .labelsHidden()
                }
            } header: {
                error.isEmpty ? Text("Please sign in to continue.") : Text(error).foregroundColor(.red)
            }
        }
        .formStyle(.grouped)
        .navigationTitle("Sign in")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Sign in") {
                    if password.count == 19 {
                        signin()
                    } else {
                        error = "Signing in with main password is not allowed"
                    }
                }
                .disabled(isButtonDisabled || (handle.isEmpty || password.isEmpty))
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    exit(0)
                }
            }
        }
    }
}
