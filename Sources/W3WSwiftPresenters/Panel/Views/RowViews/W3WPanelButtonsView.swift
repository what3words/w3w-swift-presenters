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

struct W3WPanelButtonsView<ViewModel: W3WPanelViewModelProtocol>: View {
  @State private var cancellable: AnyCancellable?

  var buttons: [W3WButtonData]
  
  var text: W3WLive<W3WString>

  var scheme: W3WScheme?

  @State var liveText = W3WString()

  // view model
  @ObservedObject var viewModel: ViewModel

  var body: some View {
    HStack {
      if liveText.asString() != "" {
        W3WTextView(liveText
          .style(
            color: W3WColor(
              light: W3WCoreColor.black,
              dark: W3WCoreColor.white
            )
          )
        )
        Spacer()
      }

      ForEach(buttons) { button in
        if let title = button.title {
          Button(title, action: button.onTap)
            .padding(EdgeInsets(top: 10.0, leading: 16.0, bottom: 10.0, trailing: 16.0))
            .foregroundColor(scheme?.colors?.highlight?.foreground?.current.suColor)
            .background((button.highlight == .primary)
                        ? scheme?.colors?.secondaryBackground?.current.suColor
                        : W3WColor.w3wFillsSenary.suColor)
            .clipShape(.rect(cornerRadius: 8))
        }
      }
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
    .background(scheme?.colors?.background?.current.suColor)
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

  
  W3WPanelButtonsView(
    buttons: [
      W3WButtonData(icon: .badge, title: "titleA", onTap: { }),
      W3WButtonData(icon: .gearshape, title: "titleB", highlight: .secondary, onTap: { }),
      W3WButtonData(icon: .camera, title: "titleC", onTap: { }),
    ],
    text: W3WLive<W3WString>(W3WString("1 selected")),
    viewModel: W3WPanelViewModel(scheme: scheme, language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en"))))
}
