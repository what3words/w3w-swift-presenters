//
//  W3WButtonData.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation
import W3WSwiftThemes


public struct W3WButtonData: Identifiable {
  public var id = UUID()
  
  var icon: W3WImage?
  var title: String?
  var onTap: () -> ()
  
  public init(icon: W3WImage? = nil, title: String? = nil, onTap: @escaping () -> Void) {
    self.id = UUID()
    self.icon = icon
    self.title = title
    self.onTap = onTap
  }
  
}
