//
//  W3WButtonData.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation
import W3WSwiftThemes


public struct W3WButtonData: Identifiable {
  public let id = UUID()
  
  public var icon: W3WImage?
  public var title: String?
  public var highlight: W3WOrdinal
  public var onTap: () -> ()
  
  public init(icon: W3WImage? = nil, title: String? = nil, highlight: W3WOrdinal = .primary, onTap: @escaping () -> Void) {
    self.icon = icon
    self.title = title
    self.onTap = onTap
    self.highlight = highlight
  }
}
