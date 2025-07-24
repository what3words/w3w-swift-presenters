//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 06/04/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes
import W3WSwiftDesign

struct W3WPanelButtonsView: View {

  @State var buttons: [W3WButtonData]

  @State var theme: W3WTheme?

  var body: some View {
    HStack {
      ForEach(buttons) { button in
        _Button(button: button, theme: theme)
      }
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
  }
}

private extension W3WPanelButtonsView {
  struct _Button: View {
    @ObservedObject var button: W3WButtonData
    
    @State var theme: W3WTheme?
    
    // Consider using a preference key to track the biggest width
    private let minButtonWidth: CGFloat = 93
    
    var body: some View {
      if let title = button.title {
        //TODO: - (Kaley) Can replace this with W3WSUButton (?)
        Button(action: button.onTap) {
          Text(title)
            .padding(.vertical, W3WPadding.extraMedium.value)
            .padding(.horizontal, W3WPadding.bold.value)
            .frame(minWidth: minButtonWidth)
            .foregroundColor(theme?.labelsSecondary?.suColor)
            .background(
              button.highlight == .primary
              ? theme?.fillsQuaternary?.suColor
              : theme?.fillsSenary?.suColor
            )
            .clipShape(.rect(cornerRadius: buttonCornerRadius))
        }
      }
    }
    
    private var buttonCornerRadius: CGFloat {
      W3WPadding.light.value
    }
  }
}

#Preview {
  W3WPanelButtonsView(
    buttons: [
      W3WButtonData(icon: .badge, title: "titleA", onTap: { }),
      W3WButtonData(icon: .gearshape, title: "titleB", highlight: .secondary, onTap: { }),
      W3WButtonData(icon: .camera, title: "titleC", onTap: { }),
    ])
}
