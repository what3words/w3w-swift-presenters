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

  var scheme: W3WScheme?

  
  public init(viewModel: ViewModel, scheme: W3WScheme? = nil) {
    self.viewModel = viewModel
    self.scheme = scheme
  }
  
  
  public var body: some View {
    VStack(spacing: 0) {
      header
      ScrollView {
        ForEach((0...viewModel.items.listNormal.count - 1), id: \.self) { index in
          W3WPanelRowView(viewModel: viewModel, item: viewModel.items.listNormal[index], scheme: scheme)
        }
      }
      footer
    }
    .background(scheme?.colors?.background?.current.suColor)
    .layoutDirectionFromAppearance()
  }
  
  @ViewBuilder
  private var header: some View {
    if let header = viewModel.items.getHeader() {
      W3WPanelRowView(
        viewModel: viewModel,
        item: header,
        scheme: scheme
      )
    }
  }
  
  @ViewBuilder
  private var footer: some View {
    if let footer = viewModel.items.getFooter() {
      VStack {
        Divider()
          .shadow(radius: 1, x: 0, y: 1)
        W3WPanelRowView(viewModel: viewModel, item: viewModel.items.list[0], scheme: scheme)
      }
      .padding(.top, 16)
      .background(scheme?.colors?.background?.current.suColor)
    }
  }
}

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  var items = W3WPanelViewModel(scheme: W3WLive<W3WScheme?>(.w3w), language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en")), translations: nil)

  W3WPanelScreen(viewModel: items, scheme: .w3w)
}
