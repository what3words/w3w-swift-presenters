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

  @State var theme: W3WTheme?

  // view model
  @ObservedObject var viewModel: ViewModel

  var body: some View {
    HStack {
      Spacer()
      Text(title.asString())
        .scheme(textScheme)
      .multilineTextAlignment(.center)
      .frame(alignment: .center)
      .padding(W3WPadding.medium.value)
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .animation(.easeInOut(duration: 0.1))
  }
  
  var textScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .body, weight: .bold)
  }
}
