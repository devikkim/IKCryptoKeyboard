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
  @IBOutlet fileprivate weak var encryptedTextField: UITextField!
  @IBOutlet fileprivate weak var decryptedTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pwTextField.delegate = self
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
    
    var configure = IKCryptoKeyBoardConfigure()

    configure.isUseSubKeys = false
    configure.numberQwerty = "1234567890"
    configure.mainQwerty.firstLine = "яшертыуиопющэ"
    configure.mainQwerty.secondLine = "асдфгчйкльж"
    configure.mainQwerty.thirdLine = "зхцвбнм"

    configure.color.defaultButton = UIColor.white
    configure.color.touchedButton = UIColor.black
    configure.color.keyboardBackground = UIColor.white
    configure.color.functionKeyTextColor = UIColor.red
    configure.color.keyTextColor = UIColor.gray
    vc.configure = configure
    
    self.present(vc, animated: true)
  }
}


extension ViewController: IKCryptoKeyBoardViewControllerDelegate {
  func encrypted(plain: String, encryptedData: String) {
    self.pwTextField.text = plain
    self.encryptedTextField.text = encryptedData
  }
}
