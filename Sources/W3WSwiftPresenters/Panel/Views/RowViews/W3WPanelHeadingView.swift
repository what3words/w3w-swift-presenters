//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import W3WSwiftThemes


struct W3WPanelHeadingView: View {
  
  let title: String
  
  let isCentered: Bool
  
  let theme: W3WTheme?

  var body: some View {
    Text(title)
      .scheme(textScheme)
      .multilineTextAlignment(.center)
      .frame(alignment: .center)
      .padding(W3WPadding.medium.value)
      .frame(maxWidth: .infinity, alignment: isCentered ? .center : .leading)
  }
  
  var textScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .body, weight: .bold)
  }
}
