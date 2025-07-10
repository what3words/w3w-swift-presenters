//
//  W3WMultiPurposeItemList.swift
//  w3w-swift-app-presenters
//
//  Created by Dave Duprey on 31/03/2025.
//

import Foundation


public struct W3WOrderedItem<T> {
  public enum Kind {
      case normal
      case header
      case footer
    }
  
  let id = UUID()
  
  let item: T
  
  let order: Float
  
  let kind: Kind
  
  
  public init(item: T, order: Float, kind: Kind = .normal) {
    self.item = item
    self.order = order
    self.kind = kind
  }
}


public class W3WPanelItemList {
  
  var items: [W3WOrderedItem<W3WPanelItem>]
  
  public var list: [W3WPanelItem] {
    items.sorted(by: { i, j in i.order < j.order }).map { i in return i.item }
  }
  
  public var listNormal: [W3WPanelItem] {
    items.sorted(by: { i, j in i.order < j.order })
      .filter({ $0.kind == .normal })
      .map { i in return i.item }
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
  
  
  public func getHeader() -> W3WPanelItem? {
    items.first(where: { $0.kind == .header })?.item
  }
  
  
  public func getFooter() -> W3WPanelItem? {
    items.first(where: { $0.kind == .footer })?.item
  }
  
  
  public func set(header: W3WPanelItem?) {
    if let header {
      items.append(W3WOrderedItem(item: header, order: newHighOrder(), kind: .header))
    } else {
      items.removeAll(where: { $0.kind == .header })
    }
  }
  
  
  public func set(footer: W3WPanelItem?) {
    if let f = footer {
      items.append(W3WOrderedItem(item: f, order: newLowOrder(), kind: .footer))
    } else {
      items.removeAll(where: { $0.kind == .footer })
    }
  }

}
