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
  
  var body: some View {
    switch item {
      
    case .heading(let text):
      W3WPanelHeadingView(title: text.value, theme: viewModel.theme, viewModel: viewModel)
      
    case .message(let message):
      W3WPanelMessageView(message: message, theme: viewModel.theme, viewModel: viewModel)
      
    case .actionItem(icon: let icon, text: let text, let button):
      W3WPanelActionItemView(icon: icon, text: text, button: button, theme: viewModel.theme)
      
    case .button(let button):
      W3WPanelPrimaryActionView(button: button, theme: viewModel.theme)
      
    case .buttons(let buttons):
      W3WPanelButtonsView(buttons: buttons, theme: viewModel.theme)
      
    case .buttonsAndTitle(let buttons, text: let text):
      W3WPanelButtonsAndTitleView(buttons: buttons, text: text, theme: viewModel.theme)
      
    case .suggestions(let suggestions):
      W3WPanelSuggestionsView(suggestions: suggestions,
                              theme: viewModel.theme,
                              language: viewModel.language,
                              translations: viewModel.translations)
      
    default:
      Text("?")
    }
  }
}
