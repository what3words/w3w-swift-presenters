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
  /// An enum used as a unique identifier for tracking the height of different view components
  private enum Height {
    case footer
  }
  
  // main view model
  @ObservedObject var viewModel: ViewModel

  var scheme: W3WScheme?

  /// The dynamically measured height of footer,
  @State private var footerHeight: CGFloat = 0
  
  public init(viewModel: ViewModel, scheme: W3WScheme? = nil) {
    self.viewModel = viewModel
    self.scheme = scheme
  }
  
  
  public var body: some View {
    ScrollView {
      ForEach((0...viewModel.items.listNoFooters.count - 1), id: \.self) { index in
        W3WPanelRowView(viewModel: viewModel, item: viewModel.items.listNoFooters[index], scheme: scheme)
      }
      // Bottom padding to prevent the items at the bottom from being obscured
      Spacer()
        .frame(height: footerHeight)
    }
    .overlay(footer, alignment: .bottom)
    .background(scheme?.colors?.background?.current.suColor)
    .layoutDirectionFromAppearance()
  }
  
  @ViewBuilder
  private var footer: some View {
    if let footer = viewModel.items.getFooter() {
      VStack {
        Divider()
          .shadow(radius: 1, x: 0, y: 1)
        W3WPanelRowView(viewModel: viewModel, item: footer, scheme: scheme)
          .background(scheme?.colors?.background?.current.suColor)
      }
      .padding(.top, 16)
      .onHeightChange($footerHeight, for: Height.footer)
    }
  }
}

#Preview {
  let s1 = W3WBaseSuggestion(words: "xxx.xxx.xxx", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s2 = W3WBaseSuggestion(words: "yyyy.yyyy.yyyy", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s3 = W3WBaseSuggestion(words: "zz.zz.zz", country: W3WBaseCountry(code: "ZZ"), nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))
  let s4 = W3WBaseSuggestion(words: "reallyreally.longverylong.threewordaddress", nearestPlace: "place place placey", distanceToFocus: W3WBaseDistance(meters: 1234.0))

  var items = W3WPanelViewModel(scheme: W3WLive<W3WScheme?>(.w3w), language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en")))

  W3WPanelScreen(viewModel: items, scheme: .w3w)
}




//            switch viewModel.items.list[index] {
//
//              case .heading(let text):
//                W3WPanelHeadingView(title: text.value, viewModel: viewModel)
//
//              case .message(let message):
//                W3WPanelMessageView(message: message, viewModel: viewModel)
//
//              case .actionItem(icon: let icon, text: let text, let button):
//                W3WPanelActionItemView(icon: icon, text: text, button: button)
//
//              case .buttons(let buttons, text: let text):
//                W3WPanelButtonsView(buttons: buttons, text: text, viewModel: viewModel)
//
//              case .tappableRow(icon: let image, text: let text):
//                W3WPanelTappableRow(icon: image, text: text)
//
//                //case .suggestion(let suggestion, let selected):
//                //  W3WPanelSuggestionView(suggestion: suggestion, scheme: theme?.basicScheme(), selected: selected?.value, onTap: { print(suggestion) })
//
//              case .suggestions(let suggestions):
//                W3WPanelSuggestionsView(suggestions: suggestions)
//
//                //  W3WPanelMessageView(message: suggestion.words ?? "", viewModel: viewModel)
//
//                //          case .address(address: let address, let buttons):
//                //            W3WPanelMessageView(message: W3WLive<W3WString>(address), viewModel: viewModel)
//                //
//                //          case .notification(let notification):
//                //            W3WPanelMessageView(message: notification.message?.asString() ?? "", viewModel: viewModel)
//                //
//                //          case .route(time: let time, distance: let distance, eta: let eta, let buttons):
//                //            W3WPanelMessageView(message: time.value.seconds.description, viewModel: viewModel)
//                //
//                //          case .routeFinished(let suggestion):
//                //            W3WPanelMessageView(message: suggestion.words ?? "", viewModel: viewModel)
//                //
//                //          case .segmentedControl(let buttons):
//                //            W3WPanelMessageView(message: buttons.description, viewModel: viewModel)
//                //
//                //          case .selectableSuggestion(let suggestion, let value):
//                //            W3WPanelMessageView(message: (suggestion.words ?? "") + (value.value ? "on" : "off"), viewModel: viewModel)
//                //
//                //          case .title(let title):
//                //            W3WPanelMessageView(message: title.value.asString(), viewModel: viewModel)
//
//              default:
//                Text("?")
//            }
