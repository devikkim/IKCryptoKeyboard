//
//  IKCryptoKeyboardView.swift
//  FBSnapshotTestCase
//
//  Created by InKwon on 20/11/2018.
//

import UIKit

protocol IKCryptoKeyboardViewDelegate : class {
  func touched(keys: String)
  func comfirmTouch(plain: String)
}

class IKCryptoKeyboardView: UIView{

  
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var numberKeysView: UIStackView!
  @IBOutlet var firstKeysView: UIStackView!
  @IBOutlet var secondKeysView: UIStackView!
  @IBOutlet var thirdKeysView: UIStackView!
  
  @IBOutlet var shiftButton: UIButton!
  @IBOutlet var specialButton: UIButton!
  @IBOutlet var comfirmButton: UIButton!
  @IBOutlet var backspaceButton: UIButton!
  @IBOutlet var spaceButton: UIButton!
  
  var configure: IKCryptoKeyBoardConfigure!
  
  var delegate: IKCryptoKeyboardViewDelegate?
  
  fileprivate var userInputText = ""
  fileprivate var isShift = false
  fileprivate var isSpecial = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initFromNibName()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.initFromNibName()
  }
  
  fileprivate func initFromNibName(){
    let name = String(describing: type(of: self))
    let nib = UINib(nibName: name, bundle: Bundle(for: IKCryptoButton.self))
    nib.instantiate(withOwner: self, options: nil)
    
    self.addSubview(self.contentView)
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
  }
  
  fileprivate func setButtonUI(){
    self.contentView.backgroundColor = configure.color.keyboardBackground
    
    self.comfirmButton.layer.cornerRadius = 5.0
    self.comfirmButton.setTitleColor(configure.color.functionKeyTextColor, for: .normal)
    self.backspaceButton.layer.cornerRadius = 5.0
    self.backspaceButton.setTitleColor(configure.color.functionKeyTextColor, for: .normal)
    self.spaceButton.layer.cornerRadius = 5.0
    self.spaceButton.setTitleColor(configure.color.functionKeyTextColor, for: .normal)
    self.shiftButton.layer.cornerRadius = 5.0
    self.shiftButton.setTitleColor(configure.color.functionKeyTextColor, for: .normal)
    self.specialButton.layer.cornerRadius = 5.0
    self.specialButton.setTitleColor(configure.color.functionKeyTextColor, for: .normal)
  } 
}

extension IKCryptoKeyboardView: IKCryptoButtonDelegate {
  func touchedKey(key: String) {
    self.userInputText += key
    self.delegate?.touched(keys: self.userInputText)
  }
  
}

extension IKCryptoKeyboardView {
  func setKeys(type: IKKeyboardTypes){
    
    self.setButtonUI()
    
    var keyboardInfo = IKKeyboardInformation(configure: configure)
    
    switch type {
    case .main:
      keyboardInfo.setKeyFrom(type: .main)
    case .shift:
      keyboardInfo.setKeyFrom(type: .shift)
    case .special:
      keyboardInfo.setKeyFrom(type: .special)
    }
    
    for view in self.numberKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in self.firstKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in self.secondKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in self.thirdKeysView.subviews {
      view.removeFromSuperview()
    }
    
    for button in keyboardInfo.numberKeyArray {
      button.delegate = self
      self.numberKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.firstKeyArray {
      button.delegate = self
      self.firstKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.secondKeyArray {
      button.delegate = self
      self.secondKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.thirdKeyArray {
      button.delegate = self
      self.thirdKeysView.addArrangedSubview(button)
    }
  }
}

extension IKCryptoKeyboardView {
  @IBAction func shiftTouch(sender:UIButton){
    if self.isShift {
      self.setKeys(type: IKKeyboardTypes.main)
      self.isShift = false
      
      shiftButton.backgroundColor = configure.color.defaultButton
    } else {
      self.setKeys(type: IKKeyboardTypes.shift)
      self.isShift = true
      
      shiftButton.backgroundColor = configure.color.touchedButton
    }
  }
  
  @IBAction func spacialTouch(sender:UIButton){
    if self.isSpecial {
      self.setKeys(type: IKKeyboardTypes.main)
      self.isSpecial = false
      specialButton.backgroundColor = configure.color.defaultButton
      
      self.shiftButton.isHidden = false
    } else {
      self.setKeys(type: IKKeyboardTypes.special)
      self.isSpecial = true
      specialButton.backgroundColor = configure.color.touchedButton
      
      self.shiftButton.isHidden = true
    }
  }
  
  @IBAction func spaceTouch(sender:UIButton){
    self.userInputText += " "
    self.delegate?.touched(keys: userInputText)
  }
  
  @IBAction func backspaceTouch(sender:UIButton){
    if self.userInputText.count != 0 {
      let endIndex = userInputText.index(userInputText.endIndex, offsetBy: -1)
      self.userInputText = String(userInputText[..<endIndex])
      self.delegate?.touched(keys: userInputText)
    }
  }
  
  @IBAction func comfirmTouch(sender:UIButton){
    delegate?.comfirmTouch(plain: userInputText)
  }
  
}
