//
//  W3WMultiPurposeItemViewModelProtocol.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes


/// A panel view that contains list items
public protocol W3WPanelViewModelProtocol: ObservableObject {
  
  /// the items in the list
  var items: W3WPanelItemList { get set }
  
  /// input events
  var input: W3WEvent<W3WPanelInputEvent> { get set }
  
  /// output events
  var output: W3WEvent<W3WPanelOutputEvent> { get set }
  
  /// the scheme to use
  var scheme: W3WScheme? { get set }

}
