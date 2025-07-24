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

struct W3WPanelPrimaryActionView: View {
  let button: W3WButtonData
  
  @State var theme: W3WTheme?
  
  var body: some View {
    Button(action: button.onTap) {
      Text(button.title ?? "")
        .padding(.vertical, W3WPadding.bold.value)
        .frame(maxWidth: .infinity)
        .foregroundColor(W3WColor.w3wLabelsPrimaryWhite.suColor)
        .background(theme?.fillsSecondary?.suColor)
        .clipShape(.rect(cornerRadius: 8))
    }
    .padding(.bottom, W3WPadding.light.value)
    .padding(.horizontal, W3WPadding.bold.value)
  }
}
