//
//  File.swift
//  w3w-swift-presenters
//
//  Created by Hoang Ta on 25/7/25.
//

import SwiftUI
import W3WSwiftThemes


struct W3WPanelTitleView: View {
  
  let title: String

  let theme: W3WTheme?

  var body: some View {
    Text(title)
      .scheme(theme?
        .labelScheme(grade: .primary, fontStyle: .body, weight: .bold)
        .with(foreground: W3WColor.w3wLabelsPrimaryBlackInverse)
      )
      .frame(height: 30)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 16)
      .padding(.bottom, 8)
  }
}
