//
//  W3WMultiPurposeItemViewModelProtocol.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


/// A panel view that contains list items
public protocol W3WPanelViewModelProtocol: ObservableObject {
  
  var header: [W3WPanelItem]? { get }
  
  var content: [W3WPanelItem] { get }

  var footer: [W3WPanelItem]? { get }
  
  var isSelectable: Bool { get }
  
  var hasSuggestions: AnyPublisher<Bool, Never> { get }
  
  func add(suggestions: [W3WSuggestion])
  
  func toggleSelection(_ suggestion: W3WSuggestion)
  
  func isSelected(_ suggestion: W3WSuggestion) -> Bool
  
  func viewSelection(_ suggestion: W3WSuggestion)
  
  func reset()
  
  /// input events
  var input: W3WEvent<W3WPanelInputEvent> { get set }
  
  /// output events
  var output: W3WEvent<W3WPanelOutputEvent> { get set }
  
  var theme: W3WTheme? { get set }
  
  var language: W3WLanguage? { get set }
  
  var translations: W3WTranslationsProtocol { get }
}
