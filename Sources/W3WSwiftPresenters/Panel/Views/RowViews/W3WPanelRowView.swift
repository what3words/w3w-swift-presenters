//
//  SwiftUIView.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 16/05/2025.
//

import SwiftUI
import W3WSwiftThemes


struct W3WPanelRowView<ViewModel: W3WPanelViewModelProtocol>: View {
  
  // main view model
  @ObservedObject var viewModel: ViewModel
  
  let item: W3WPanelItem
  
  var scheme: W3WScheme?

  
  var body: some View {
    switch item {
      
    case .heading(let text):
      W3WPanelHeadingView(title: text.value, scheme: scheme, viewModel: viewModel)
      
    case .message(let message):
      W3WPanelMessageView(message: message, scheme: scheme, viewModel: viewModel)
      
    case .actionItem(icon: let icon, text: let text, let button):
      W3WPanelActionItemView(icon: icon, text: text, button: button, scheme: scheme)
      
    case .buttons(let buttons, text: let text):
      W3WPanelButtonsView(buttons: buttons, text: text, scheme: scheme, viewModel: viewModel)
      
    case .tappableRow(icon: let image, text: let text):
      W3WPanelTappableRow(icon: image, text: text, scheme: scheme)
      
    case .suggestions(let suggestions):
      W3WPanelSuggestionsView(suggestions: suggestions, scheme: scheme)
      
    default:
      Text("?")
    }
  }
}
