//
//  SwiftUIView.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 06/04/2025.
//

import SwiftUI
import Combine
import W3WSwiftCore
import W3WSwiftThemes
import W3WSwiftDesign

struct W3WPanelButtonsView<ViewModel: W3WPanelViewModelProtocol>: View {
  @State private var cancellable: AnyCancellable?

  var buttons: [W3WButtonData]
  
  var text: W3WLive<W3WString>

  var scheme: W3WScheme?

  @State var liveText = W3WString()

  // view model
  @ObservedObject var viewModel: ViewModel

  var body: some View {
    HStack {
      if liveText.asString() != "" {
        W3WTextView(liveText)
        Spacer()
      }

      ForEach(buttons) { button in
        if let title = button.title {
          Button(action: { button.onTap() }, label: { Text(title) })
            .padding(EdgeInsets(top: 10.0, leading: 16.0, bottom: 10.0, trailing: 16.0))
            .foregroundColor(scheme?.colors?.highlight?.foreground?.current.suColor)
            .background(scheme?.colors?.secondaryBackground?.current.suColor)
            .clipShape(Capsule())
        }
      }
    }
    .padding()
    .background(scheme?.colors?.background?.current.suColor)
    
    .onAppear { // Subscribe to the text changes
      //if let t = text {
        cancellable = text
          .sink { content in
            liveText = text.value
          }
      //}
    }
    .onDisappear {
      // Cancel the subscription
      cancellable?.cancel()
    }
  }
}



#Preview {
  W3WPanelButtonsView(
    buttons: [
      W3WButtonData(icon: .badge, title: "title", onTap: { }),
      W3WButtonData(icon: .camera, title: "title", onTap: { }),
//      W3WButtonData(icon: .gearshape, title: "title", onTap: { }),
//      W3WButtonData(icon: .badgeFill, title: "title", onTap: { })
    ],
    text: W3WLive<W3WString>(W3WString("1 selected")),
    viewModel: W3WPanelViewModel(scheme: W3WLive<W3WScheme?>(.w3w), language: W3WLive<W3WLanguage?>(W3WBaseLanguage(locale: "en")))
  )
}



//ScrollView(.horizontal, showsIndicators: false) {
//  HStack { // Add some spacing between buttons
//    if let text = text?.value {
//      W3WTextView(text)
//    }
//    ForEach(buttons) { button in
//      if let title = button.title {
//        Button(action: { button.onTap() }, label: {
//          HStack {
//            if let icon = button.icon {
//              Image(uiImage: icon.get())
//            }
//            if let t = button.title {
//              Text(t)
//            }
//          }.padding(EdgeInsets(top: 10.0, leading: 16.0, bottom: 10.0, trailing: 16.0))
//        }
//        )
//        .foregroundColor(W3WColor.darkBlue.suColor)
//        .background(W3WColor.lightBlue.suColor)  //(viewModel.scheme?.colors?.secondaryBackground?.current.suColor)
//        .clipShape(Capsule())
//      }
//    }
//  }
//  .background(Color.gray)
//  .frame(maxWidth: .infinity) // Allow the HStack to expand to the full width of the ScrollView
//  .padding()
//}
