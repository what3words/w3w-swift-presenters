//
//  W3WMultiPurposeOutputEvent.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import W3WSwiftCore

public enum W3WPanelOutputEvent {
  case retry
  case setSelectionMode(Bool) // true: enable, false: disable
  case selectAllItems(Bool) // true: select all, false: deselect all
  case viewSuggestion(suggestion: W3WSuggestion)
  case saveSuggestions(title: String, suggestions: [W3WSuggestion])
  case shareSuggestion(title: String, suggestion: W3WSuggestion)
  case viewSuggestions(title: String, suggestions: [W3WSuggestion])
}
