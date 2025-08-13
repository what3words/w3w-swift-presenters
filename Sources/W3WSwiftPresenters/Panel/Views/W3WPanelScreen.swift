//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import SwiftUI
import W3WSwiftCore
import W3WSwiftThemes

public struct W3WPanelScreen<ViewModel: W3WPanelViewModelProtocol>: View {
  // main view model
  @ObservedObject var viewModel: ViewModel
  
  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      if let header = viewModel.header {
        rows(header)
      }
      if !viewModel.content.isEmpty {
        ScrollView {
          rows(viewModel.content)
        }
      }
      if let footer = viewModel.footer {
        VStack {
          Divider().shadow(radius: 1, x: 0, y: 1)
          rows(footer)
        }
      }
    }
    .background(viewModel.theme?.systemBackgroundBasePrimary?.suColor)
  }
    
  private func rows(_ items: [W3WPanelItem]) -> some View {
    ForEach(items) { item in
      W3WPanelRowView(viewModel: viewModel, item: item)
    }
  }
}

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  let items = W3WPanelViewModel(
    mode: .live,
    isProUser: .init(true),
    theme: nil,
    language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en")),
    translations: W3WMockTranslation()
  )

  W3WPanelScreen(viewModel: items)
}
