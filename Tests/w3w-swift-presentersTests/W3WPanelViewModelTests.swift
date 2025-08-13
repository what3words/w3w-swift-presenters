//
//  W3WPanelViewModelTests.swift
//  w3w-swift-presenters
//
//  Created by Hoang Ta on 6/8/25.
//

import Testing
import W3WSwiftCore
@testable import W3WSwiftPresenters

/// For behavior reference:
/// https://www.notion.so/what3words/OCR-Scan-Result-display-logic-1fb4eb2734f780b3b138c8f10b419fb0
@MainActor
struct W3WPanelViewModelTests {
  private let translations: W3WMockTranslation = .init()
  
  private let sampleSuggestions: [W3WSuggestion] = [
    W3WBaseSuggestion(words: "candle.planet.neatly"),
    W3WBaseSuggestion(words: "butter.lakes.fruit"),
    W3WBaseSuggestion(words: "viewer.mouse.rocket")
  ]
  
  @Test func liveScanInitialStates() async throws {
    // Given
    let viewModel = makeViewModel(mode: .live)
    
    // Then
    let header = try #require(viewModel.header?.first)
    #expect(header.id == W3WPanelItem.heading(translations.get(id: "ocr_scan_3wa")).id)
    let content = try #require(viewModel.content.first)
    #expect(content.id == W3WPanelItem.suggestions([]).id)
    #expect(viewModel.footer == nil)
  }
  
  @Test func singleShotInitialStates() async throws {
    // Given
    let viewModel = makeViewModel(mode: .singleShot)
    
    // Then
    #expect(viewModel.header == nil)
    let content = try #require(viewModel.content.first)
    #expect(content.id == W3WPanelItem.suggestions([]).id)
    #expect(viewModel.footer == nil)
  }
  
  @Test func addSuggestionsAsProUser() async throws {
    // Given
    let viewModel = makeViewModel()
    
    // When
    viewModel.add(suggestions: sampleSuggestions)
    
    // Then
    let header = try #require(viewModel.header?.first)
    switch header {
    case .buttons(let buttonData):
      #expect(buttonData.count == 2)
      #expect(buttonData[0].highlight == .secondary)
      #expect(buttonData[1].highlight == .secondary)
      
    default: Issue.record("W3WPanelItem header is not buttons")
    }
    #expect(viewModel.isSelectable == false)
    #expect(viewModel.footer == nil)
  }
  
  @Test func addSuggestionsAsFreeUser() async throws {
    // Given
    let viewModel = makeViewModel(mode: .singleShot, isProUser: false)
    
    // When
    viewModel.add(suggestions: sampleSuggestions)
    
    // Then
    let header = try #require(viewModel.header?.first)
    switch header {
    case .heading: break // Expected
    default: Issue.record("W3WPanelItem header is not heading")
    }
    #expect(viewModel.isSelectable == false)
    #expect(viewModel.footer == nil)
  }
  
  @Test func select() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectButton).onTap()
    
    // Then
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .primary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .secondary)
  }
  
  @Test func select2Times() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectButton).onTap()
    try #require(viewModel.selectButton).onTap()
    
    // Then
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .secondary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .secondary)
  }
  
  @Test(arguments: zip([
    [0], // Select 1st suggestion
    [0, 1], // Select 1st & 2nd suggestions
    [0, 1, 0] // Select 1st & 2nd suggestions then deselect 1st
  ], [
    (3, "1"), // 3 visible buttons, 1 selected
    (2, "2"), // 2 visible buttons, 2 selected
    (3, "1") // 3 visible buttons, 1 selected
  ]))
  func togglesSuggestions(
    suggestionIndice: [Int],
    buttonCountAndHighlightedText: (Int, String)
  ) async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectButton).onTap()
    for index in suggestionIndice {
      viewModel.toggleSelection(sampleSuggestions[index])
    }
    
    // Then
    let (buttonData, _, highlightedText) = try #require(viewModel.footerButtonsAndTitle)
    #expect(buttonData.count == buttonCountAndHighlightedText.0)
    #expect(highlightedText == buttonCountAndHighlightedText.1)
  }
  
  @Test func selectAll() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectAllButton).onTap()
    
    // Then
    for suggestion in sampleSuggestions {
      #expect(viewModel.isSelected(suggestion) == true)
    }
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .secondary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .primary)
  }
  
  @Test func selectAll2Times() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectAllButton).onTap()
    try #require(viewModel.selectAllButton).onTap()
    
    // Then
    for suggestion in sampleSuggestions {
      #expect(viewModel.isSelected(suggestion) == false)
    }
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .secondary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .secondary)
  }
  
  @Test func selectThenSelectAll() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectButton).onTap()
    try #require(viewModel.selectAllButton).onTap()
    
    // Then
    for suggestion in sampleSuggestions {
      #expect(viewModel.isSelected(suggestion) == true)
    }
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .secondary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .primary)
  }
  
  @Test func selectAllThenSelect() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectAllButton).onTap()
    try #require(viewModel.selectButton).onTap()
    
    // Then
    for suggestion in sampleSuggestions {
      #expect(viewModel.isSelected(suggestion) == false)
    }
    let selectButton = try #require(viewModel.selectButton)
    #expect(selectButton.highlight == .primary)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .secondary)
  }
  
  @Test(arguments: zip([
    [0], // Deselect 1st suggestion
    [0, 1], // Deselect 1st & 2nd suggestions
  ], [
    2, // 2 visible buttons 2 selected
    3, // 3 visible buttons, 1 selected
  ]))
  func selectAllThenManuallyDeselectSuggestions(
    suggestionIndice: [Int],
    buttonCount: Int
  ) async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectAllButton).onTap()
    for index in suggestionIndice {
      viewModel.toggleSelection(sampleSuggestions[index])
    }
    
    // Then
    let (buttonData, _, _) = try #require(viewModel.footerButtonsAndTitle)
    #expect(buttonData.count == buttonCount)
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .primary)
  }
  
  @Test func selectAllThenToggleOneSuggestionThenSelectAllAgain() async throws {
    // Given
    let viewModel = makeViewModelThenAddSuggestions()
    
    // When
    try #require(viewModel.selectAllButton).onTap()
    viewModel.toggleSelection(sampleSuggestions[0])
    try #require(viewModel.selectAllButton).onTap()
    
    // Then
    for suggestion in sampleSuggestions {
      #expect(viewModel.isSelected(suggestion) == true)
    }
    let selectAllButton = try #require(viewModel.selectAllButton)
    #expect(selectAllButton.highlight == .primary)
  }
}

// MARK: - Helpers
private extension W3WPanelViewModelTests {
  func makeViewModel(mode: W3WPanelViewModel.Mode = .live, isProUser: Bool = true) -> W3WPanelViewModel {
    W3WPanelViewModel(mode: mode, isProUser: .init(isProUser), theme: nil, language: nil, translations: translations)
  }
  
  func makeViewModelThenAddSuggestions(
    mode: W3WPanelViewModel.Mode = .live
  ) -> W3WPanelViewModel {
    let viewModel = makeViewModel(mode: mode)
    viewModel.add(suggestions: sampleSuggestions)
    return viewModel
  }
  
  func selectButton(from viewModel: W3WPanelViewModel) -> W3WButtonData? {
    guard let header = viewModel.header?.first else { return nil }
    switch header {
    case .buttons(let buttonData) where buttonData.count > 1: return buttonData[1]
    default: return nil
    }
  }
}

// MARK: - W3WPanelViewModel Helpers
private extension W3WPanelViewModel {
  var selectButton: W3WButtonData? { selectButtons?.first }
  
  var selectAllButton: W3WButtonData? { selectButtons?.last }
  
  var selectButtons: [W3WButtonData]? {
    guard let header = header?.first else { return nil }
    switch header {
    case .buttons(let buttonData) where buttonData.count > 1: return buttonData
    default: return nil
    }
  }
  
  var footerButtonsAndTitle: ([W3WButtonData], String, String?)? {
    guard let footer = footer?.first else { return nil }
    switch footer {
    case let .buttonsAndTitle(buttonData, text, highlightedText):
      return (buttonData, text, highlightedText)
      
    default: return nil
    }
  }
}
