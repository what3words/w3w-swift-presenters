//
//  W3WMultiPurposeItemList.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation



public struct W3WOrderedItem<T> {
  
  let id = UUID()
  
  let item: T
  
  let order: Float
  
  let footer: Bool
  
  
  public init(item: T, order: Float, footer: Bool = false) {
    self.item = item
    self.order = order
    self.footer = footer
  }
}


public class W3WPanelItemList {
  
  var items: [W3WOrderedItem<W3WPanelItem>]
  
  public var list: [W3WPanelItem] {
    get {
      return items.sorted(by: { i, j in i.order < j.order }).map { i in return i.item }
    }
  }
  
  public var listNoFooters: [W3WPanelItem] {
    get {
      return items.sorted(by: { i, j in i.order < j.order }).filter({ i in return !i.footer }).map { i in return i.item }
    }
  }

  
  public init(items: [W3WOrderedItem<W3WPanelItem>]) {
    self.items = items
  }
  
  
  public func lowestOrder() -> Float {
    return items.min(by: { i, j in i.order < j.order })?.order ?? 1.0
  }
  
  
  public func highestOrder() -> Float {
    return items.max(by: { i, j in i.order < j.order })?.order ?? 1.0
  }

  
  public func newLowOrder() -> Float {
    return lowestOrder() - 1.0
  }

  
  public func newHighOrder() -> Float {
    return highestOrder() + 1.0
  }
  
  
  public func prepend(item: W3WPanelItem) {
    items.append(W3WOrderedItem(item: item, order: newLowOrder()))
  }
  
  
  public func insert(item: W3WPanelItem, order: Float) {
    items.append(W3WOrderedItem(item: item, order: order))
  }
  
  
  public func append(item: W3WPanelItem) {
    items.append(W3WOrderedItem(item: item, order: newHighOrder()))
  }
  
  
  public func remove(item: W3WPanelItem) {
    items.removeAll(where: { i in i.item == item })
  }
  
  
  public func isFooter(index: Int) -> Bool {
    return items[index].footer
  }
  
  
  public func getFooter() -> W3WPanelItem? {
    items.first(where: { i in i.footer == true })?.item
  }
  
  
  public func set(footer: W3WPanelItem?) {
    if let f = footer {
      items.append(W3WOrderedItem(item: f, order: newLowOrder(), footer: true))
      
    } else {
      items.removeAll(where: { i in i.footer == true })
    }
  }

}
