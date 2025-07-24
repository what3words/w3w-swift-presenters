//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 04/04/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


struct W3WPanelActionItemView: View {
  @State private var cancellable: AnyCancellable?

  var icon: W3WImage
  var text: W3WLive<W3WString>
  var button: W3WButtonData
  @State var theme: W3WTheme?

  @State var liveText = NSAttributedString()

  var body: some View {
    HStack {
      Image(uiImage: icon.get())
      Text(liveText.string)
        .scheme(theme?.labelScheme(grade: .secondary, fontStyle: .subheadline, weight: .regular))
      Spacer()
      Button(button.title ?? "", action: { button.onTap() })
    }
    .padding()
    .onAppear {
      // Subscribe to the CurrentValueSubject and update the countText on change
      cancellable = text
        .sink { content in
          liveText = text.value.asAttributedString()
        }
    }
    .onDisappear {
      // Cancel the subscription when the view disappears
      cancellable?.cancel()
    }
  }
}


//#Preview {
//  W3WPanelActionItemView()
//}
