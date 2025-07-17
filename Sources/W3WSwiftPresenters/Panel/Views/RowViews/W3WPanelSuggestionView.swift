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
  @State private var cancellable: AnyCancellable?
  
  let suggestion: W3WSelectableSuggestion
  
  let language: W3WLanguage?
  
  let translations: W3WTranslationsProtocol?
  
  var showDivider: Bool = true
  
  let scheme: W3WScheme?
  
  let onTap: () -> Void
  
  @State var selected: Bool?
  
  
  var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 0) {
      if let selected {
        circleIcon(isSelected: selected)
          .padding(.horizontal, W3WPadding.medium.value)
      } else {
        Spacer()
          .frame(width: W3WPadding.bold.value)
      }
      
      W3WTextView("".w3w
        .style(font: scheme?.styles?.font?.body)
        .withSlashes()
      )
      
      HStack(alignment: .firstTextBaseline, spacing: 0) {
        VStack(alignment: .leading, spacing: W3WPadding.fine.value) {
          W3WTextView((suggestion.suggestion.words ?? "----.----.----")
            .w3w
            .style(
              color: W3WColor.w3wLabelsTertiary,
              font: scheme?.styles?.font?.body
            )
          )
          .lineLimit(1)
          .allowsTightening(true)
          .minimumScaleFactor(0.5)
          
          HStack {
            W3WTextView(nearestPlace
              .w3w
              .style(
                color: W3WColor.w3wLabelsQuaternary,
                font: scheme?.styles?.font?.footnote
              )
            )
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.5)
            
            Spacer()
            
            W3WTextView(
              suggestion.suggestion.distanceToFocus?.description
                .w3w
                .style(
                  color: W3WColor.w3wLabelsQuaternary,
                  font: scheme?.styles?.font?.footnote
                ) ?? "".w3w)
            .padding(.trailing)
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
    .layoutDirection(for: suggestion.suggestion.language)
    .onTapGesture(perform: onTap)
    .onAppear {
      cancellable = suggestion.selected
        .sink { value in
          selected = value
        }
    }
    .onDisappear {
      cancellable?.cancel()
    }
  }
}

// MARK: - Helpers
private extension W3WPanelSuggestionView {
  var nearestPlace: String {
    // currently, display 'near' keyword in English language only. Should improve later after we update our localisations for all languages
    guard let placeName = suggestion.suggestion.nearestPlace else { return "" }
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

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s1, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s2, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s3, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s4, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s1, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s2, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s3, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s1, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s2, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s3, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s1, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s2, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
  W3WPanelSuggestionView(suggestion: W3WSelectableSuggestion(suggestion: s3, selected: false), language: nil, translations: nil, scheme: .standard) { print("x") }
}
