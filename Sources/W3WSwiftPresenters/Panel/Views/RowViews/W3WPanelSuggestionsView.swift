//
//  SwiftUIView.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 11/05/2025.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes


struct W3WPanelSuggestionsView: View {

  let suggestions: [W3WSuggestion]
  
  let isSelectable: Bool
  
  let isSelected: (W3WSuggestion) -> Bool
  
  let toggleSelection: (W3WSuggestion) -> Void
  
  let viewSelection: (W3WSuggestion) -> Void
  
  @State var theme: W3WTheme?

  @State var language: W3WLanguage?
  
  let translations: W3WTranslationsProtocol?
  
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(suggestions, id: \.words) { suggestion in
          W3WPanelSuggestionView(
            suggestion: suggestion,
            language: language,
            translations: translations,
            isSelectable: isSelectable,
            isSelected: isSelected(suggestion),
            showDivider: suggestion.words != suggestions.last?.words,
            theme: theme) {
              if isSelectable {
                toggleSelection(suggestion)
              } else {
                viewSelection(suggestion)
              }
          }
        }
      }
    }
  }
}


#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  
  W3WPanelSuggestionsView(
    suggestions: [s1, s2, s3, s4],
    isSelectable: true,
    isSelected: { _ in false },
    toggleSelection: { _ in },
    viewSelection: { _ in },
    translations: nil)
}
