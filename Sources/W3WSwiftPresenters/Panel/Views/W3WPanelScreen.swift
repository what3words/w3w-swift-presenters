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
      header
      ScrollView {
        ForEach(viewModel.items.listNormal, id: \.id) { item in
          W3WPanelRowView(viewModel: viewModel, item: item)
        }
      }
      footer
    }
    .background(viewModel.theme?.systemBackgroundBasePrimary?.suColor)
  }
  
  @ViewBuilder
  private var header: some View {
    if let header = viewModel.items.getHeader() {
      W3WPanelRowView(
        viewModel: viewModel,
        item: header
      )
    }
  }
  
  @ViewBuilder
  private var footer: some View {
    if let _ = viewModel.items.getFooter() {
      VStack {
        Divider()
          .shadow(radius: 1, x: 0, y: 1)
        W3WPanelRowView(viewModel: viewModel, item: viewModel.items.list[0])
      }
      .padding(.top, 16)
    }
  }
}

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  var items = W3WPanelViewModel(theme: nil, language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en")), translations: nil)

  W3WPanelScreen(viewModel: items)
}
