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

struct W3WPanelButtonsAndTitleView: View {
  @State private var cancellable: AnyCancellable?

  var buttons: [W3WButtonData]
  
  var text: W3WLive<W3WString>

  @State var theme: W3WTheme?

  @State var liveText = W3WString()

  var body: some View {
    HStack(spacing: W3WPadding.none.value) {
      if liveText.asString() != "" {
        // TODO: - Should fix highlighted text
        Text(liveText.asString())
          .scheme(theme?.labelScheme(grade: .primary, fontStyle: .body, weight: .regular).with(foreground: W3WColor.w3wLabelsPrimaryBlackInverse))
        Spacer()
      }
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
    .onAppear { // Subscribe to the text changes
      cancellable = text
        .sink { content in
          liveText = text.value
        }
    }
    .onDisappear {
      // Cancel the subscription
      cancellable?.cancel()
    }
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
    text: W3WLive<W3WString>(W3WString("1 selected")))
}
