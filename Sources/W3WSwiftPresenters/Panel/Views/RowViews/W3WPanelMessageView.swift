//
//  W3WPanelMessageView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 04/04/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


struct W3WPanelMessageView<ViewModel: W3WPanelViewModelProtocol>: View {
  @State private var cancellable: AnyCancellable?

  var message: W3WLive<W3WString>

  @State var theme: W3WTheme?
  
  // view model
  @ObservedObject var viewModel: ViewModel

  @State var liveText = W3WString()


  var body: some View {
    HStack {
      Text(message.value.string.string)
        .scheme(theme?.labelScheme(grade: .tertiary, fontStyle: .body, weight: .bold))
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .animation(.easeInOut(duration: 0.1))
    .onAppear {
      // Subscribe to the CurrentValueSubject and update the countText on change
      cancellable = message
        .sink { content in
          liveText = message.value
        }
    }
    .onDisappear {
      // Cancel the subscription when the view disappears
      cancellable?.cancel()
    }
    .padding()
  }
}


//#Preview {
//    SwiftUIView()
//}
