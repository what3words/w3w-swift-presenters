//
//  SwiftUIView.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 02/05/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


struct W3WPanelSuggestionView: View {
  let suggestion: W3WSuggestion
  
  let language: W3WLanguage?
  
  let translations: W3WTranslationsProtocol?
  
  var isSelectable: Bool = false
  
  var isSelected: Bool = false
  
  var showDivider: Bool = true
  
  @State var theme: W3WTheme?
  
  let onTap: () -> Void

  
  var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 0) {
      if isSelectable {
        circleIcon(isSelected: isSelected)
          .padding(.horizontal, W3WPadding.medium.value)
      } else {
        Spacer()
          .frame(width: W3WPadding.bold.value)
      }
      
      W3WTextView("".w3w
        .style(font: theme?.labelScheme(grade: .primary, fontStyle: .body, weight: .medium).styles?.font)
        .withSlashes()
      )
      
      HStack(alignment: .firstTextBaseline, spacing: 0) {
        VStack(alignment: .leading, spacing: W3WPadding.fine.value) {
          Text(suggestion.words ?? "----.----.----")
            .scheme(wordsScheme)
          .lineLimit(1)
          .allowsTightening(true)
          .minimumScaleFactor(0.5)
          
          HStack {
            Text(nearestPlace)
              .scheme(nearestPlaceScheme)
            .lineLimit(1)
            .allowsTightening(false)
            
            Spacer()
            
            Text(suggestion.distanceToFocus?.description ?? "")
              .scheme(distanceScheme)
          }
        }
      }
      .padding(.trailing, W3WPadding.bold.value)
      .padding(.vertical, W3WPadding.medium.value)
      .overlay(VStack {
        if showDivider {
          Spacer()
          Divider()
        }
      })
    }
    .contentShape(Rectangle())
    .layoutDirection(for: suggestion.language)
    .onTapGesture(perform: onTap)
  }
}

// MARK: - Helpers
private extension W3WPanelSuggestionView {
  var nearestPlace: String {
    // currently, display 'near' keyword in English language only. Should improve later after we update our localisations for all languages
    guard let placeName = suggestion.nearestPlace else { return "" }
    if let language, language.code == "en", let translations {
      let nearString = translations.get(id: "near")
      return String(format: "%@ %@", nearString, placeName)
    }
    return placeName
  }
  
  
  func circleIcon(isSelected: Bool) -> some View {
    if isSelected {
      return Image(uiImage: W3WImage.checkmarkCircleFill.get())
        .renderingMode(.template)
        .foregroundColor(W3WColor.w3wLabelsSecondary.suColor)
    } else {
      return Image(uiImage: W3WImage.circle.get())
        .renderingMode(.template)
        .foregroundColor(W3WColor(light: .core.grey60, dark: .core.grey30).suColor)
    }
  }
}

private extension W3WPanelSuggestionView {
  var nearestPlaceScheme: W3WScheme? {
    theme?.labelScheme(grade: .quaternary, fontStyle: .footnote, weight: .regular)
  }
  
  var distanceScheme: W3WScheme? {
    theme?.labelScheme(grade: .quaternary, fontStyle: .footnote, weight: .bold)
  }
  
  var wordsScheme: W3WScheme? {
    theme?.labelScheme(grade: .tertiary, fontStyle: .body, weight: .semibold)
  }
}

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  W3WPanelSuggestionView(suggestion: s1, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s2, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s3, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s4, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s1, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s2, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s3, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s4, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s2, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s3, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s1, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s2, language: nil, translations: nil) { print("x") }
  W3WPanelSuggestionView(suggestion: s3, language: nil, translations: nil) { print("x") }
}
