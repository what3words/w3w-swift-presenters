//
//  W3WMutliPurposeItem.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation
import Combine
import W3WSwiftCore
import W3WSwiftThemes

public enum W3WPanelItem: Identifiable {
  case button(W3WButtonData)
  case buttons([W3WButtonData])
  case buttonsAndTitle([W3WButtonData], text: String, highlightedText: String?)
  case suggestions([W3WSuggestion])
  case title(String)
  case heading(String)

  public var id: String {
    switch self {
    case .button(let button):
      return button.title ?? "button"
      
    case .buttons(let buttons):
      return "\(buttons.count) buttons"
      
    case let .buttonsAndTitle(buttons, title, _):
      return "\(buttons.count) buttons & \(title)"
      
    case .suggestions(let suggestions):
      return suggestions.description
      
    case .title(let text):
      return text
      
    case .heading(let text):
      return text
    }
  }
}
