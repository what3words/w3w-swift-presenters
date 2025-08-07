//
//  W3WMultiPurposeItemViewModel.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes


/// A panel view that contains list items
public class W3WPanelViewModel: W3WPanelViewModelProtocol, W3WEventSubscriberProtocol {
  
  public var subscriptions = W3WEventsSubscriptions()
  
  /// the items in the list
  @Published public var items = W3WPanelItemList(items: [])
  
  @Published public var theme: W3WTheme?
  
  @Published public var language: W3WLanguage?
  
  public var translations: W3WTranslationsProtocol?
  /// input events
  public var input = W3WEvent<W3WPanelInputEvent>()
  
  /// output events
  public var output = W3WEvent<W3WPanelOutputEvent>()
  
  
  /// main app implementation of the logic for notifications
  /// - Parameters:
  ///     - scheme: the scheme to use for he views
  ///     - language: the language in use, used for writting direction
  public init(theme: W3WLive<W3WTheme?>? = nil, language: W3WLive<W3WLanguage?>? = nil, translations: W3WTranslationsProtocol?) {
    self.translations = translations
    self.theme = theme?.value
    subscribe(to: input) { [weak self] event in
      self?.handle(event: event)
    }
    
    subscribe(to: theme) { [weak self] theme in
      self?.theme = theme
    }
    
    subscribe(to: language) { [weak self] language in
      self?.handle(language: language)
    }
  }
  
  /// handle a language change
  func handle(language: W3WLanguage?) {
    self.language = language
  }
  
  /// handle a scheme change
  func handle(theme: W3WTheme?) {
    self.theme = theme
  }
  
  /// handle in input event
  func handle(event: W3WPanelInputEvent) {
    switch event {
    case .add(item: let item):
      items.prepend(item: item)
      
    case .remove(item: let item):
      items.remove(item: item)
      
    case .header(item: let item):
      items.set(header: item)
    case .footer(item: let item):
      items.set(footer: item)
    }
    
    objectWillChange.send()
  }
  
}
