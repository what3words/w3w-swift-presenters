//
//  W3WMutliPurposeItem.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation
import Combine
import W3WSwiftCore
import W3WSwiftThemes
//import W3WSwiftAppTypes

@available(*, deprecated, message: "W3WNotificaiton should be moved to W3WSwiftDesign if it's to work here")
public struct W3WNotification { }

public enum W3WPanelItem: Equatable, CustomStringConvertible, Identifiable {
  case button(W3WButtonData)
  case buttons([W3WButtonData])
  case buttonsAndTitle([W3WButtonData], text: W3WLive<W3WString> = W3WLive<W3WString>("".w3w))
  case tappableRow(icon: W3WImage, text: W3WLive<W3WString>)
  case address(address: String, [W3WButtonData])
  case message(W3WLive<W3WString>)
  case suggestion(W3WSuggestion, selected: W3WLive<Bool>? = nil)
  case suggestions(W3WSelectableSuggestions)
  case segmentedControl([W3WButtonData])
  case route(time: W3WLive<W3WDuration>, distance: W3WLive<W3WDistance>, eta: W3WLive<Date>, [W3WButtonData])
  case routeFinished(W3WSuggestion)
  case title(String)
  case heading(W3WLive<W3WString>)
  case notification(W3WNotification)
  case actionItem(icon: W3WImage, text: W3WLive<W3WString>, W3WButtonData)

  public var id: String {
    self.description
  }
  
  public static func == (lhs: W3WPanelItem, rhs: W3WPanelItem) -> Bool {
    switch (lhs, rhs) {
    case (.message(let lhsString), .message(let rhsString)):
      return lhsString.value.asString() == rhsString.value.asString()
      
    case (.heading(let lhsString), .heading(let rhsString)):
      return lhsString.value.asString() == rhsString.value.asString()
      
    case (.button(let lhsButton), .button(let rhsButton)):
      return lhsButton.title == rhsButton.title
      
      // this isn't perfect, needs a more rigourous compare.  It only compares the id of the first button
    case (.buttons(let lhsButtons), .buttons(let rhsButtons)):
      return lhsButtons.first?.id == rhsButtons.first?.id
      
    case (.buttonsAndTitle(let lhsButtons, _), .buttonsAndTitle(let rhsButtons, _)):
      return (lhsButtons.first?.id == rhsButtons.first?.id) //&& (lhsText.value.asString() == rhsText.value.asString())
      
    default:
      return false
    }
  }
  
  
  public var description: String {
    switch self {
    case .button(let button):
      return "button: \(button.title ?? "no title")"
      
    case .buttons(let buttons):
      return "\(buttons.count) buttons"
      
    case let .buttonsAndTitle(buttons, title):
      return "\(buttons.count) buttons & \(title.value.asString())"
      
    case .tappableRow(_, text: let text):
      return "row: " + text.value.asString()
      
    case .address(address: let address, _):
      return "address: " + address.description
      
    case .message(let message):
      return message.value.description
      
    case .suggestion(let suggestion, _):
      return suggestion.description
      
    case .suggestions(let suggestions):
      return suggestions.suggestions.description
      
    case .segmentedControl(let control):
      return "Control with \(control.count) values"
      
    case .route(time: let time, distance: let distance, _, _):
      return "route: \(time.value.seconds) seconds, \(distance.value.description)"
      
    case .routeFinished(_):
      return "route finished"
      
    case .title(let text):
      return text
      
    case .heading(let text):
      return text.value.asString()
      
    case .notification:
      return "notification"
      
    case .actionItem(_, text: let text, _):
      return "action:" + text.value.asString()
    }
  }
}
