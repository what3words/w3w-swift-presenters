//
//  W3WButtonData.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation
import W3WSwiftThemes


public class W3WButtonData: Identifiable {
  public var id = UUID()
  
  public var icon: W3WImage?
  public var title: String?
  public var highlight: W3WOrdinal
  public var onTap: () -> ()
  
  public init(icon: W3WImage? = nil, title: String? = nil, highlight: W3WOrdinal = .primary, onTap: @escaping () -> Void) {
    self.id = UUID()
    self.icon = icon
    self.title = title
    self.onTap = onTap
    self.highlight = highlight
  }
  
}
