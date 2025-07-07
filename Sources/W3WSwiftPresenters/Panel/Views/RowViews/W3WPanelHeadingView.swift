//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import W3WSwiftThemes


struct W3WPanelHeadingView<ViewModel: W3WPanelViewModelProtocol>: View {
  
  var title: W3WString

  var scheme: W3WScheme?

  // view model
  @ObservedObject var viewModel: ViewModel

  var body: some View {
    HStack {
      Spacer()
      W3WTextView(
        title.style(
          color: scheme?.colors?.header?.foreground,
          font: scheme?.styles?.fonts?.headline
        ),
        separator: false
      )
      .frame(alignment: .center)
      //.foregroundColor(scheme?.colors?.header?.foreground?.current.suColor)
      .background(scheme?.colors?.background?.suColor)
      .padding(W3WPadding.medium.value)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    //.background(scheme?.colors?.secondaryBackground?.suColor)
    .listRowBackground(scheme?.colors?.secondaryBackground?.suColor)
    .animation(.easeInOut(duration: 0.1))
  }
}


//#Preview {
//    SwiftUIView()
//}
