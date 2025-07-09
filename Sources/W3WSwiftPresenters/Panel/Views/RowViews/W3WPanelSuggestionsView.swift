//
//  SwiftUIView.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 11/05/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes


struct W3WPanelSuggestionsView: View {
  @State private var cancellable: AnyCancellable?

  var suggestions: W3WSelectableSuggestions
  
  @State var scheme: W3WScheme?

  @State private var refresh = false
  
  
  var body: some View {
    ScrollView {
      if refresh == true || refresh == false { }
      VStack(spacing: 0) {
        ForEach(suggestions.suggestions) { selectableSuggestion in
          W3WPanelSuggestionView(suggestion: selectableSuggestion, scheme: .standard) {
            if let s = selectableSuggestion.selected.value {
              selectableSuggestion.selected.send(!s)
            } else {
              suggestions.singleSelection(selectableSuggestion.suggestion)
            }
          }
        }
      }
    }
    
    // Subscribe to suggestions.update
    .onAppear {
      cancellable = suggestions.update.sink { content in
        refresh.toggle()
      }
    }
    .onDisappear { // Cancel the subscription when the view disappears
      cancellable?.cancel()
    }

  }
  
}


#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  
  var suggestions = W3WSelectableSuggestions()
  suggestions.add(suggestion: s1, selected: false)
  suggestions.add(suggestion: s2)
  suggestions.add(suggestion: s3, selected: false)
  suggestions.add(suggestion: s4, selected: true)

  return W3WPanelSuggestionsView(suggestions: suggestions)
}
