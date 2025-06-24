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

  /// the scheme to use
  @Published public var scheme: W3WScheme?
  
  /// input events
  public var input = W3WEvent<W3WPanelInputEvent>()
  
  /// output events
  public var output = W3WEvent<W3WPanelOutputEvent>()
  
  
  /// main app implementation of the logic for notifications
  /// - Parameters:
  ///     - scheme: the scheme to use for he views
  ///     - language: the language in use, used for writting direction
  public init(scheme: W3WLive<W3WScheme?>? = nil, language: W3WLive<W3WLanguage?>? = nil) {
    subscribe(to: input) { [weak self] event in
      self?.handle(event: event)
    }
    
    subscribe(to: scheme) { [weak self] scheme in
      self?.handle(scheme: scheme)
    }
    
    subscribe(to: language) { [weak self] language in
      self?.handle(language: language)
    }
  }
  
  
  /// handle a language change
  func handle(language: W3WLanguage?) {
  }
  
  
  /// handle a scheme change
  func handle(scheme: W3WScheme?) {
    self.scheme = scheme
  }
  
  
  /// handle in input event
  func handle(event: W3WPanelInputEvent) {
    switch event {
      case .add(item: let item):
        items.prepend(item: item)

      case .remove(item: let item):
        items.remove(item: item)
        
      case .footer(item: let item):
        items.set(footer: item)
    }

    objectWillChange.send()
  }
  
}
