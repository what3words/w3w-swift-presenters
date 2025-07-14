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

  var buttons: [W3WButtonData]

  var scheme: W3WScheme?

  private let minButtonWidth: CGFloat = 93
  
  var body: some View {
    HStack {
      ForEach(buttons) { button in
        if let title = button.title {
          Button(action: button.onTap) {
            Text(title)
              .padding(EdgeInsets(top: 10.0, leading: 16.0, bottom: 10.0, trailing: 16.0))
              .frame(minWidth: minButtonWidth)
              .foregroundColor(scheme?.colors?.highlight?.foreground?.current.suColor)
              .background((button.highlight == .primary)
                          ? scheme?.colors?.secondaryBackground?.current.suColor
                          : W3WColor.w3wFillsSenary.suColor)
              .clipShape(.rect(cornerRadius: 8))
          }
        }
      }
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
    .background(scheme?.colors?.background?.current.suColor)
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

  
  W3WPanelButtonsView(
    buttons: [
      W3WButtonData(icon: .badge, title: "titleA", onTap: { }),
      W3WButtonData(icon: .gearshape, title: "titleB", highlight: .secondary, onTap: { }),
      W3WButtonData(icon: .camera, title: "titleC", onTap: { }),
    ])
}
