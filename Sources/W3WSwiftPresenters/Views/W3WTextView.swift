//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 04/04/2025.
//

import SwiftUI
import W3WSwiftThemes


/// A text view that shows a W3WString
/// Marked-up strings are only available in
/// ios 15, so this falls back to plain text when
/// the OS version is 14 or lower.
public struct W3WTextView: View {
  
  var text: W3WString
  
  var separator: Bool
  
  /// A text view that shows a W3WString
  /// - Parameters:
  ///     - text: the marked up string to show
  ///     - separator: adds a listRowSeparator modifier if tru
  public init(_ text: W3WString, separator: Bool = false) {
    self.text = text
    self.separator = separator
  }
  

  /// Text view
  public var body: some View {
    if #available(iOS 15.0, *) {
      Text(AttributedString(text.asAttributedString()))
        .listRowSeparator(separator ? .automatic : .hidden)
      
    } else {
      Text(text.asString())
    }
  }
  
}


#Preview {
  W3WTextView("test.test.test".w3w.withSlashes())
}
