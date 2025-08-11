//
//  W3WSelectableSuggestion.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 11/05/2025.
//

import Foundation
import W3WSwiftCore

@available(*, deprecated, message: "No longer needed in new bottom sheet logic")
public class W3WSelectableSuggestion: Identifiable, ObservableObject {
  public var id: UUID
  let suggestion: W3WSuggestion
  var selected: W3WLive<Bool?>
  
  
  public init(suggestion: W3WSuggestion, selected: Bool? = false) {
    self.id = UUID()
    self.suggestion = suggestion
    self.selected = W3WLive<Bool?>(selected)
  }
  
  
  public init(suggestion: W3WSuggestion, selected: W3WLive<Bool?>) {
    self.id = UUID()
    self.suggestion = suggestion
    self.selected = selected
  }
}
