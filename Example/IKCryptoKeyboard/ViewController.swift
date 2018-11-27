//
//  ViewController.swift
//  IKCryptoKeyboard
//
//  Created by leibniz55 on 11/07/2018.
//  Copyright (c) 2018 leibniz55. All rights reserved.
//

import UIKit
import IKCryptoKeyboard

class ViewController: UIViewController, UITextFieldDelegate{
  
  @IBOutlet fileprivate weak var pwTextField: UITextField!
  @IBOutlet fileprivate weak var encryptedView: UITextView!
  @IBOutlet fileprivate weak var decryptedView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pwTextField.delegate = self
//    encryptedTextView.text = ""
//    decryptedTextView.text = ""
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    _ = textField.resignFirstResponder()
    
    let vc = IKCryptoKeyBoardViewController()
    vc.delegate = self
    
    self.present(vc, animated: true)
  }
}


extension ViewController: IKCryptoKeyBoardViewControllerDelegate {
  func didEncrypted(plain: String, encryptedData: Array<UInt8>) {
    self.pwTextField.text = plain
    encryptedView.text = encryptedData.toBase64()!
  }
  
  func didDecrypted(decryptedData: Array<UInt8>) {
    if let decrypted = String(bytes: decryptedData, encoding: .utf8){
      decryptedView.text = decrypted
    } else {
      decryptedView.text = decryptedData.toHexString()
    }
  }
}
