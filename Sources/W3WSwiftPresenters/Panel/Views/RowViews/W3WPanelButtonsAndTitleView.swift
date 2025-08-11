//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 06/04/2025.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes
import W3WSwiftDesign
import W3WSwiftDesignSwiftUI

struct W3WPanelButtonsAndTitleView: View {
  let buttons: [W3WButtonData]
  let text: String
  let highlightedText: String?
  
  @State var theme: W3WTheme?
  
  var body: some View {
    HStack(spacing: W3WPadding.none.value) {
      W3WHighlightedText(
        text: text,
        color: textScheme?.colors?.foreground?.suColor,
        font: textScheme?.styles?.font,
        highlightedText: highlightedText,
        highlightedTextColor: highlightedTextScheme?.colors?.foreground?.suColor,
        highlightedTextFont: highlightedTextScheme?.styles?.font
      )
      Spacer()
      HStack {
        ForEach(buttons) { button in
          if let title = button.title {
            Button(action: button.onTap) {
              HStack(spacing: W3WPadding.fine.value) {
                if let icon = button.icon {
                  Image(uiImage: icon.get())
                    .renderingMode(.template)
                }
                Text(title)
                  .lineLimit(1)
              }
              .padding(.vertical, W3WPadding.extraMedium.value)
              .padding(.leading, W3WPadding.light.value)
              .padding(.trailing, W3WPadding.medium.value)
              .foregroundColor(theme?.labelsSecondary?.suColor)
              .background((button.highlight == .primary)
                          ? theme?.fillsQuaternary?.suColor
                          : theme?.fillsSenary?.suColor)
              .clipShape(.capsule)
            }
          }
        }
      }
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
    .background(theme?.systemBackgroundBasePrimary?.suColor)
  }
}

extension W3WPanelButtonsAndTitleView {
  var textScheme: W3WScheme? {
    theme?.labelScheme(grade: .primary, fontStyle: .body, weight: .regular).with(foreground: W3WColor.w3wLabelsPrimaryBlackInverse)
  }
  
  var highlightedTextScheme: W3WScheme? {
    theme?.labelScheme(grade: .primary, fontStyle: .body, weight: .bold).with(foreground: W3WColor.w3wLabelsPrimaryBlackInverse)
  }
}


#Preview {
  let scheme = W3WLive<W3WScheme?>(
    W3WScheme(colors: W3WColors(
      foreground: .white,
      background: .lightBlue,
      secondaryBackground: .blue
    ))
  )
  
  
  W3WPanelButtonsAndTitleView(
    buttons: [
      W3WButtonData(icon: .badge, title: "titleA", onTap: { }),
      W3WButtonData(icon: .gearshape, title: "titleB", highlight: .secondary, onTap: { }),
      W3WButtonData(icon: .camera, title: "titleC", onTap: { }),
    ],
    text: "1 selected",
    highlightedText: nil)
}
