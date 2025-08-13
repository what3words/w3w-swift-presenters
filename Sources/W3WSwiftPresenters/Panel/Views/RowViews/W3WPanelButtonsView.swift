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

  let buttons: [W3WButtonData]

  @State var theme: W3WTheme?

  // Consider using a preference key to track the biggest width
  private let minButtonWidth: CGFloat = 93
  
  var body: some View {
    HStack {
      ForEach(buttons) { button in
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
              .clipShape(.rect(cornerRadius: W3WPadding.light.value))
          }
        }
      }
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
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
