//
//  IKCryptoButtonView.swift
//  FBSnapshotTestCase
//
//  Created by InKwon on 20/11/2018.
//

import UIKit
import AudioToolbox

protocol IKCryptoButtonDelegate: class {
  func touchedKey(key:String)
}

class IKCryptoButton: UIButton {
  @IBOutlet var contentView: UIView!
  @IBOutlet var mainKeyLabel: UILabel!
  @IBOutlet var subKeyLabel: UILabel!
  @IBOutlet var bigKey: UILabel!
  
  var keySet: IKKeySet!
  
  var delegate: IKCryptoButtonDelegate?
  
  var isTouch = false
  
  var configure: IKCryptoKeyBoardConfigure!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    initFromNibName()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    initFromNibName()
  }
  
  private func initFromNibName(){
    let name = String(describing: type(of: self))
    let nib = UINib(nibName: name, bundle: Bundle(for: IKCryptoButton.self))
    nib.instantiate(withOwner: self, options: nil)
    
    contentView.layer.cornerRadius = 5.0
    addSubview(contentView)
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: self.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
  }

}

extension IKCryptoButton {
  func setKeySet(keySet: IKKeySet){
    self.keySet = keySet
    
    if keySet.subKey == "" {
      bigKey.text = keySet.mainKey
    } else {
      mainKeyLabel.text = keySet.mainKey
      subKeyLabel.text = keySet.subKey
    }
    
    setColor()
  }
  
  private func setColor(){
    contentView.backgroundColor = configure.color.defaultKeyBackground
    bigKey.textColor = configure.color.defaultKeyText
    mainKeyLabel.textColor = configure.color.defaultKeyText
    subKeyLabel.textColor = configure.color.defaultKeyText
  }
  
}

extension IKCryptoButton {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    isTouch = true
    contentView.backgroundColor = configure.color.touchedKeyBackground
    
    // added haptic
    IKUtilities.OccurHaptic()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touchedKey = keySet.mainKey
    
    delegate?.touchedKey(key: touchedKey!)
    
    if isTouch {
      isTouch = false
      contentView.backgroundColor = configure.color.defaultKeyBackground
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isTouch {
      isTouch = false;
      contentView.backgroundColor = configure.color.defaultKeyBackground
    }
  }
  
}
