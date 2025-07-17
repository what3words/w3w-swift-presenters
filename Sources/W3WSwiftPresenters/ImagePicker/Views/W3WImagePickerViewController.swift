//
//  W3WImagePickerViewModel.swift
//  w3w-swift-components-ocr
//
//  Created by Dave Duprey on 06/05/2025.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers



public class W3WImagePickerViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  public var viewModel: W3WImagePickerViewModelProtocol?
  
  /// keeps a reference to objects to keep them alive and release them on destruction
  public var keepAlive: [Any?] = []
  
  /// Indicates whether an image has already been picked by the user.
  ///
  /// If this flag is `true`, it means the image picker has already completed its task,
  /// and therefore the dismiss action (e.g. closing the picker manually) should be skipped
  /// to avoid redundant or unintended behavior.
  private var hasPickedImage = false
  
  public func set(viewModel: W3WImagePickerViewModelProtocol, keepAlive: [Any?] = []) {
    self.viewModel = viewModel
    self.keepAlive = keepAlive

    mediaTypes = [kUTTypeImage as String]
    //sourceType = .camera
    
    delegate = self
  }
  
  
  override public func viewDidLoad() {
    delegate = self
  }

  public override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    if isBeingDismissed && !hasPickedImage {
      viewModel?.output.send(.dismiss)
    }
  }

  
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard
      let image = info[.originalImage] as? UIImage,
      let cgImage = image.cgImage else { return }
    hasPickedImage = true
    viewModel?.output.send(.image(cgImage))
  }

  
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    viewModel?.output.send(.dismiss)
  }
  
}
