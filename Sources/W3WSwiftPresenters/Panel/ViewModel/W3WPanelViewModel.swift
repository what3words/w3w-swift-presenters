//
//  W3WMultiPurposeItemViewModel.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


/// A panel view that contains list items
public class W3WPanelViewModel: W3WPanelViewModelProtocol, W3WEventSubscriberProtocol {
  /// Defines how the bottom sheet handles suggestions and default items.
  public enum Mode: CaseIterable {
    /// There is always an initial `W3WPanelItem` which says `Scan a what3words address`
    /// When suggestions are added, that initial item is removed.
    /// Suggestions can be added multiple times throughout the lifecycle
    case live
    
    /// Starts with no `W3WPanelItem`.
    /// Suggestions are only added once.
    /// If, after adding, there are no suggestions, a single fallback `W3WPanelItem` which says `Try Again` is inserted.
    case singleShot
  }
  
  /// Represents the current selection behavior in the panel
  private enum W3WPanelSelectionMode {
    /// Selection is disabled
    case none
    /// Selection is enabled, this can only occurs when user taps `Select All` again after the button has been tapped
    case selectable
    /// Only one item can be selected at a time
    case single
    /// All items are selected
    case all
  }
  
  public var subscriptions = W3WEventsSubscriptions()
  
  /// Items to be shown in the panel header
  public var header: [W3WPanelItem]? { _header() }
  
  /// Items to be shown in the panel content
  public var content: [W3WPanelItem] { [.suggestions(suggestions)] }
  
  /// Items to be shown in the panel footer
  public var footer: [W3WPanelItem]? { _footer() }
  
  /// Indicates whether selection is enabled
  public var isSelectable: Bool { selectionMode != .none }
  
  /// A publisher that emits `true` when there are any suggestions available
  public var hasSuggestions: AnyPublisher<Bool, Never> {
    $suggestions.map { !$0.isEmpty }.eraseToAnyPublisher()
  }
  
  @Published public var theme: W3WTheme?
  
  @Published public var language: W3WLanguage?
  
  public let translations: W3WTranslationsProtocol
  
  /// input events
  @available(*, deprecated, message: "No longer needed in new bottom sheet logic")
  public var input = W3WEvent<W3WPanelInputEvent>()
  
  /// output events
  public var output = W3WEvent<W3WPanelOutputEvent>()
  
  /// The display mode of the panel
  private let mode: Mode
  
  /// The list of suggestions currently displayed in the panel
  @Published private var suggestions: [W3WSuggestion] = []
  
  /// The set of selected suggestion identifiers (words)
  @Published private var selections = Set<String?>()
  
  /// Indicates whether any suggestions have been received since reset
  @Published private var hasReceivedSuggestions = false
  
  /// The current selection mode
  @Published private var selectionMode: W3WPanelSelectionMode = .none
  
  /// Indicates whether the user is a Pro user
  @Published private var isProUser = false
  
  /// Creates a new instance of `W3WPanelViewModel`
  /// - Parameters:
  ///   - mode: The panel's mode, which determines how suggestions are displayed
  ///   - isProUser: A live boolean value indicating whether the user has Pro access
  ///   - theme: An optional live theme
  ///   - language: An optional live language
  ///   - translations: Translations provider for localized strings
  public init(
    mode: Mode,
    isProUser: W3WLive<Bool>,
    theme: W3WLive<W3WTheme?>? = nil,
    language: W3WLive<W3WLanguage?>? = nil,
    translations: W3WTranslationsProtocol
  ) {
    self.mode = mode
    self.translations = translations
    
    subscribe(to: theme) { [weak self] theme in
      self?.theme = theme
    }
    
    subscribe(to: language) { [weak self] language in
      self?.handle(language: language)
    }
    
    subscribe(to: isProUser) { [weak self] isProUser in
      self?.isProUser = isProUser
    }
  }
  
  /// Adds a list of new suggestions to the panel, ignoring duplicates
  /// - Parameter suggestions: The suggestions to add
  public func add(suggestions: [W3WSuggestion]) {
    for suggestion in suggestions {
      if !self.suggestions.contains(where: { $0.words == suggestion.words }) {
        self.suggestions.append(suggestion)
      }
    }
    
    /// We need a check here since setting hasReceivedSuggestions
    /// to true again also triggers swiftui update
    if !hasReceivedSuggestions {
      hasReceivedSuggestions = true
    }
  }
  
  /// Checks if a suggestion is currently selected
  /// - Parameter suggestion: The suggestion to check
  public func isSelected(_ suggestion: W3WSuggestion) -> Bool {
    selections.contains(suggestion.words)
  }
  
  /// Toggles the selection state of a suggestion
  /// - Parameter suggestion: The suggestion to toggle
  public func toggleSelection(_ suggestion: W3WSuggestion) {
    guard selectionMode != .none else { return }
    
    if selections.contains(suggestion.words) {
      selections.remove(suggestion.words)
    } else {
      selections.insert(suggestion.words)
    }
  }
  
  /// Sends an event to view a specific suggestion
  /// - Parameter suggestion: The suggestion to view
  public func viewSelection(_ suggestion: W3WSuggestion) {
    output.send(.viewSuggestion(suggestion: suggestion))
  }
  
  /// Resets the panel to its initial state
  public func reset() {
    suggestions = []
    selections = []
    hasReceivedSuggestions = false
    selectionMode = .none
  }
}

// MARK: - Helpers
private extension W3WPanelViewModel {
  /// handle a language change
  func handle(language: W3WLanguage?) {
    self.language = language
  }
  
  /// handle a scheme change
  func handle(theme: W3WTheme?) {
    self.theme = theme
  }
  
  /// Builds the header items for the panel based on the current mode and suggestion state.
  /// - Returns: An array of `W3WPanelItem` for the header, or `nil` if no header should be shown.
  func _header() -> [W3WPanelItem]? {
    guard hasReceivedSuggestions else { return scanHeader }
      
    switch mode {
    case .live:
      return suggestions.isEmpty ? scanHeader : selectionHeader
      
    case .singleShot:
      return suggestions.isEmpty ? tryAgainHeader : selectionHeader
    }
  }

  /// Returns a header prompting the user to scan a what3words address.
  /// Only applies in `.live` mode.
  var scanHeader: [W3WPanelItem]? {
    switch mode {
    case .live: [W3WPanelItem.heading(translations.get(id: "ocr_scan_3wa"))]
    case .singleShot: nil
    }
  }
  
  /// Returns a header prompting the user to try again, with a retry button.
  /// Used in `.singleShot` mode when there are no suggestions.
  var tryAgainHeader: [W3WPanelItem] {
    let heading: W3WPanelItem = .heading(translations.get(id: "ocr_import_photo_errorMessage"))
    let tryAgainTitle = translations.get(id: "ocr_import_photo_tryAgainButton")
    let tryAgain: W3WPanelItem = .button(.init(title: tryAgainTitle) { [weak self] in
      self?.output.send(.retry)
    })
    return [heading, tryAgain]
  }
  
  /// Returns the header with "Select" and "Select All" buttons for pro users.
  /// Only shown if `isProUser` is `true`.
  var selectionHeader: [W3WPanelItem]? {
    guard isProUser else { return nil }
    
    let select = W3WButtonData(
      title: translations.get(id: "ocr_selectButton"),
      highlight: selectionMode == .single ? .primary : .secondary,
      onTap: toggleSingleSelectionMode)
    let selectAll = W3WButtonData(
      title: translations.get(id: "ocr_select_allButton"),
      highlight: selectionMode == .all ? .primary : .secondary,
      onTap: toggleAllSelectionMode)
    return [.buttons([select, selectAll])]
  }
  
  /// Toggles the single selection mode on and off.
  /// Resets all selections when toggling.
  /// Sends `.setSelectionMode` event with the updated state.
  func toggleSingleSelectionMode() {
    selectionMode = selectionMode == .single ? .none : .single
    selections.removeAll()
    output.send(.setSelectionMode(selectionMode == .single))
  }
  
  /// Toggles the "Select All" mode.
  /// If already in "Select All" mode and all items are selected, switches to `.selectable` mode and clears selections.
  /// Sends `.selectAllItems` event with the updated state.
  func toggleAllSelectionMode() {
    if selectionMode != .all || selections.count < suggestions.count {
      selectionMode = .all
      for suggestion in suggestions {
        selections.insert(suggestion.words)
      }
    } else {
      selectionMode = .selectable
      selections.removeAll()
    }
    output.send(.selectAllItems(selectionMode == .all))
  }
  
  /// Builds the footer items for the panel based on the current selections.
  /// - Returns: An array of `W3WPanelItem` for the footer, or `nil` if no footer should be shown.
  func _footer() -> [W3WPanelItem]? {
    let saveTitle = translations.get(id: "save")
    let save = W3WButtonData(icon: .star, title: saveTitle) { [weak self] in
      guard let self else { return }
      let selected = suggestions.filter { selections.contains($0.words) }
      output.send(.saveSuggestions(title: saveTitle, suggestions: selected))
    }
    
    let shareTitle = translations.get(id: "panel_share_location_action_title")
    let share = W3WButtonData(icon: .squareAndArrowUp, title: shareTitle) { [weak self] in
      guard let self else { return }
      guard let suggestion = suggestions.first(where: { selections.contains($0.words) })
      else { return }
      output.send(.shareSuggestion(title: shareTitle, suggestion: suggestion))
    }
    
    let viewTitle = translations.get(id: "acc_tab_map")
    let view = W3WButtonData(icon: .map, title: viewTitle) { [weak self] in
      guard let self else { return }
      let selected = suggestions.filter { selections.contains($0.words) }
      output.send(.viewSuggestions(title: viewTitle, suggestions: selected))
    }
    
    func makeItems(_ buttons: [W3WButtonData]) -> [W3WPanelItem] {
      let count = "\(selections.count)"
      let text = count + " " + translations.get(id: "ocr_w3wa_selected_number")
      return [.buttonsAndTitle(buttons, text: text, highlightedText: count)]
    }
    
    switch selections.count {
    case 0: return nil
    case 1: return makeItems([save, share, view])
    default: return makeItems([save, view])
    }
  }
}
