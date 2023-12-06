//
//  ToolTipView.swift
//  swiftsky
//

import SwiftUI

struct TooltipModifier<TootipContent: View>: ViewModifier {
    var content: TootipContent
    @State private var contenthovered = false
    @State private var isPresented = false
    @State private var work: DispatchWorkItem?
    init(@ViewBuilder content: @escaping () -> TootipContent) {
        self.content = content()
    }

    private func onHover(_ hovered: Bool) {
        work?.cancel()
        work = DispatchWorkItem(block: {
            isPresented = contenthovered
        })
        contenthovered = hovered
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: work!)
    }

    func body(content: Content) -> some View {
        content
            .onHover {
                onHover($0)
            }
            .popover(isPresented: $isPresented, arrowEdge: .bottom) {
                self.content
                    .onHover {
                        onHover($0)
                    }
            }
    }
}

public extension View {
    func tooltip(@ViewBuilder content: @escaping () -> some View) -> some View {
        modifier(TooltipModifier(content: content))
    }
}
