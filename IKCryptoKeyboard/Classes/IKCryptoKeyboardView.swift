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
    initFromNibName()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initFromNibName()
  }
  
  fileprivate func initFromNibName(){
    let name = String(describing: type(of: self))
    let nib = UINib(nibName: name, bundle: Bundle(for: IKCryptoButton.self))
    nib.instantiate(withOwner: self, options: nil)
    
    addSubview(contentView)
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
  }
  
  fileprivate func setButtonUI(){
    contentView.backgroundColor = configure.color.keyboardBackground
    
    comfirmButton.layer.cornerRadius = 5.0
    comfirmButton.setTitleColor(configure.color.functionKeyText, for: .normal)
    comfirmButton.backgroundColor = configure.color.functionKeyBackground
    
    backspaceButton.layer.cornerRadius = 5.0
    backspaceButton.setTitleColor(configure.color.functionKeyText, for: .normal)
    backspaceButton.backgroundColor = configure.color.functionKeyBackground
    
    spaceButton.layer.cornerRadius = 5.0
    spaceButton.setTitleColor(configure.color.functionKeyText, for: .normal)
    spaceButton.backgroundColor = configure.color.functionKeyBackground
    
    shiftButton.layer.cornerRadius = 5.0
    shiftButton.setTitleColor(configure.color.functionKeyText, for: .normal)
    shiftButton.backgroundColor = configure.color.functionKeyBackground
    
    specialButton.layer.cornerRadius = 5.0
    specialButton.setTitleColor(configure.color.functionKeyText, for: .normal)
    specialButton.backgroundColor = configure.color.functionKeyBackground
  } 
}

extension IKCryptoKeyboardView: IKCryptoButtonDelegate {
  func touchedKey(key: String) {
    userInputText += key
    delegate?.touched(keys: userInputText)
  }
  
}

extension IKCryptoKeyboardView {
  func setKeys(type: IKKeyboardTypes){
    
    setButtonUI()
    
    var keyboardInfo = IKKeyboardInformation(configure: configure)
    
    switch type {
    case .main:
      keyboardInfo.setKeyFrom(type: .main)
    case .shift:
      keyboardInfo.setKeyFrom(type: .shift)
    case .special:
      keyboardInfo.setKeyFrom(type: .special)
    }
    
    for view in numberKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in firstKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in secondKeysView.subviews {
      view.removeFromSuperview()
    }
    for view in thirdKeysView.subviews {
      view.removeFromSuperview()
    }
    
    for button in keyboardInfo.numberKeyArray {
      button.delegate = self
      numberKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.firstKeyArray {
      button.delegate = self
      firstKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.secondKeyArray {
      button.delegate = self
      secondKeysView.addArrangedSubview(button)
    }
    
    for button in keyboardInfo.thirdKeyArray {
      button.delegate = self
      thirdKeysView.addArrangedSubview(button)
    }
  }
}

extension IKCryptoKeyboardView {
  @IBAction func shiftTouch(sender:UIButton){
    IKUtilities.OccurHaptic()
    
    if isShift {
      setKeys(type: IKKeyboardTypes.main)
      isShift = false
      
      shiftButton.backgroundColor = configure.color.functionKeyBackground
    } else {
      setKeys(type: IKKeyboardTypes.shift)
      isShift = true
      
      shiftButton.backgroundColor = configure.color.touchedKeyBackground
    }
  }
  
  @IBAction func spacialTouch(sender:UIButton){
    IKUtilities.OccurHaptic()
    
    if isSpecial {
      setKeys(type: IKKeyboardTypes.main)
      isSpecial = false
      specialButton.backgroundColor = configure.color.functionKeyBackground
      
      shiftButton.isHidden = false
    } else {
      setKeys(type: IKKeyboardTypes.special)
      isSpecial = true
      specialButton.backgroundColor = configure.color.touchedKeyBackground
      
      shiftButton.isHidden = true
    }
  }
  
  @IBAction func spaceTouch(sender:UIButton){
    IKUtilities.OccurHaptic()
    
    userInputText += " "
    delegate?.touched(keys: userInputText)
  }
  
  @IBAction func backspaceTouch(sender:UIButton){
    IKUtilities.OccurHaptic()
    
    if self.userInputText.count != 0 {
      let endIndex = userInputText.index(userInputText.endIndex, offsetBy: -1)
      userInputText = String(userInputText[..<endIndex])
      delegate?.touched(keys: userInputText)
    }
  }
  
  @IBAction func comfirmTouch(sender:UIButton){
    IKUtilities.OccurHaptic()
    
    delegate?.comfirmTouch(plain: userInputText)
  }
}
