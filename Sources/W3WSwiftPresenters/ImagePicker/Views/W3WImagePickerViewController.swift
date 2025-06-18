//
//  W3WImagePickerViewModel.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 06/05/2025.
//

//import UIKit
//import MobileCoreServices
//import UniformTypeIdentifiers
//
//
//extension UIImagePickerController: UIImagePickerControllerDelegate {
//  
//  struct AddOnStorage {
//    nonisolated(unsafe) static var viewModel: W3WImagePickerViewModelProtocol?
//  }
//  
//  var viewModel: W3WImagePickerViewModelProtocol? {
//    get {
//      return objc_getAssociatedObject(self,&AddOnStorage.viewModel) as? W3WImagePickerViewModelProtocol
//    }
//    
//    set {
//      if let nv = newValue {
//        objc_setAssociatedObject(self, &AddOnStorage.viewModel, nv as W3WImagePickerViewModelProtocol??, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//      }
//    }
//  }
//
//  
//}


//public class W3WImagePickerViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//  
//  public var viewModel: W3WImagePickerViewModelProtocol?
//  
//  /// keeps a reference to objects to keep them alive and release them on destruction
//  public var keepAlive: [Any?] = []
//  
//  
//  public func set(viewModel: W3WImagePickerViewModelProtocol, keepAlive: [Any?] = []) {
//    self.viewModel = viewModel
//    self.keepAlive = keepAlive
//
//    mediaTypes = [kUTTypeImage as String]
//    //sourceType = .camera
//    
//    delegate = self
//  }
//  
//  
//  override public func viewDidLoad() {
//    delegate = self
//  }
//  
//  
//  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    guard let image = info[.originalImage] as? UIImage else { return }
//    if let cgImage = image.cgImage {
//      viewModel?.output.send(.image(cgImage))
//      viewModel?.output.send(.dismiss)
//    }
//  }
//
//  
//  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    viewModel?.output.send(.dismiss)
//  }
//
//  
//}
