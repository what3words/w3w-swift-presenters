//
//  W3WImagePickerViewModel.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 06/05/2025.
//

import W3WSwiftCore
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers


public class W3WImagePickerViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, @preconcurrency W3WImagePickerViewModelProtocol {
  
  public var input = W3WEvent<W3WImagePickerInputEvent>()
  
  public var output = W3WEvent<W3WImagePickerOutputEvent>()
 
  //weak var picker: UIImagePickerController?

  
  //public init(picker: UIImagePickerController) {
  //  super.init()
  //  picker.delegate = self
  //}
  
  
  //public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  //  guard let image = info[.originalImage] as? UIImage else { return }
  //  if let cgImage = image.cgImage {
  //    output.send(.image(cgImage))
  //    output.send(.dismiss)
  //  }
  //}


  //public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
  //  output.send(.dismiss)
  //}
  
}
