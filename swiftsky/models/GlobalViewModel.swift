//
//  GlobalViewModel.swift
//  swiftsky
//

import Foundation

class GlobalViewModel: ObservableObject {
    static let shared = GlobalViewModel()
    var systemLanguageCode = ""
    var systemLanguage = ""
    @Published var profile: appbskytypes.ActorDefs_ProfileViewDetailed?
    @Published var preview: URL?
}
