//
//  W3WSelectableSuggestions.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 11/05/2025.
//

import Combine
import SwiftUI
import W3WSwiftCore


public class W3WSelectableSuggestions: W3WEventSubscriberProtocol, ObservableObject {
  public var subscriptions = W3WEventsSubscriptions()
  
  @Published var suggestions = [W3WSelectableSuggestion]()

  public var update = W3WEvent<Bool>()
  
  /// called when the selection mode is off, and the user taps on a single suggestion
  public var singleSelection: (W3WSuggestion) -> () = { _ in }
  
  public var selectedSuggestions: [W3WSuggestion] {
    get {
      return suggestions.filter({ i in i.selected.value ?? false }).map { i in return i.suggestion }
    }
  }
  
  public var allSuggestions: [W3WSuggestion] {
    get {
      return suggestions.map { i in return i.suggestion }
    }
  }
  

  public init(suggestions: [W3WSelectableSuggestion] = [], update: W3WEvent<Bool> = W3WEvent<Bool>()) {
    self.suggestions = suggestions
    self.update = update
  }
  
  
  func bind(suggestion: W3WSelectableSuggestion?) {
    subscribe(to: suggestion?.selected) { [weak self] _ in
      self?.update.send(true)
    }
  }
  
  
  public func add(suggestion: W3WSuggestion?, selected: Bool? = nil) {
    if let s = suggestion {
      if let words = s.words {
        if !suggestions.contains(where: { s in s.suggestion.words == words }) {
          let s = W3WSelectableSuggestion(suggestion: s, selected: selected)
          suggestions.insert(s, at: 0)
          bind(suggestion: s)
        }
      }
    }
    //update()
    
    W3WThread.runOnMain { [weak self] in
      self?.update.send(true)
    }
  }

  
  public func add(suggestions: [W3WSuggestion], selected: Bool? = nil) {
    for suggestion in suggestions {
      add(suggestion: suggestion, selected: selected)
    }
    //update()
    
    W3WThread.runOnMain { [weak self] in
      self?.update.send(true)
    }
  }
  
  
  public func clear() {
    suggestions.removeAll()
    subscriptions = W3WEventsSubscriptions()
    
    W3WThread.runOnMain { [weak self] in
      self?.update.send(true)
    }
  }
  
  public func setAll(selected: Bool) {
    for suggestion in suggestions {
      suggestion.selected.send(selected)
    }
  }
  
  
  public func selectedCount() -> Int {
    return suggestions.count(where: { s in s.selected.value ?? false })
  }

  
  public func count() -> Int {
    return suggestions.count
  }


  public func make(selectable: Bool) {
    for suggestion in suggestions {
      suggestion.selected.send(selectable ? false : nil)
    }
  }
  
}
