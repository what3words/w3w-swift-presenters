//
//  SwiftUIView.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 16/05/2025.
//

import SwiftUI

struct W3WPanelRowView<ViewModel: W3WPanelViewModelProtocol>: View {
  
  // main view model
  @ObservedObject var viewModel: ViewModel
  
  let item: W3WPanelItem
  
  var body: some View {
    switch item {
        
      case .heading(let text):
        W3WPanelHeadingView(title: text.value, viewModel: viewModel)
        
      case .message(let message):
        W3WPanelMessageView(message: message, viewModel: viewModel)
        
      case .actionItem(icon: let icon, text: let text, let button):
        W3WPanelActionItemView(icon: icon, text: text, button: button)
        
      case .buttons(let buttons, text: let text):
        W3WPanelButtonsView(buttons: buttons, text: text, viewModel: viewModel)
        
      case .tappableRow(icon: let image, text: let text):
        W3WPanelTappableRow(icon: image, text: text)
        
        //case .suggestion(let suggestion, let selected):
        //  W3WPanelSuggestionView(suggestion: suggestion, scheme: theme?.basicScheme(), selected: selected?.value, onTap: { print(suggestion) })
        
      case .suggestions(let suggestions):
        W3WPanelSuggestionsView(suggestions: suggestions)
        
        //  W3WPanelMessageView(message: suggestion.words ?? "", viewModel: viewModel)
        
        //          case .address(address: let address, let buttons):
        //            W3WPanelMessageView(message: W3WLive<W3WString>(address), viewModel: viewModel)
        //
        //          case .notification(let notification):
        //            W3WPanelMessageView(message: notification.message?.asString() ?? "", viewModel: viewModel)
        //
        //          case .route(time: let time, distance: let distance, eta: let eta, let buttons):
        //            W3WPanelMessageView(message: time.value.seconds.description, viewModel: viewModel)
        //
        //          case .routeFinished(let suggestion):
        //            W3WPanelMessageView(message: suggestion.words ?? "", viewModel: viewModel)
        //
        //          case .segmentedControl(let buttons):
        //            W3WPanelMessageView(message: buttons.description, viewModel: viewModel)
        //
        //          case .selectableSuggestion(let suggestion, let value):
        //            W3WPanelMessageView(message: (suggestion.words ?? "") + (value.value ? "on" : "off"), viewModel: viewModel)
        //
        //          case .title(let title):
        //            W3WPanelMessageView(message: title.value.asString(), viewModel: viewModel)
        
      default:
        Text("?")
    }  }
}



//#Preview {
//    SwiftUIView()
//}
