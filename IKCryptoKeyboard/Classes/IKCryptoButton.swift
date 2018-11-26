//
//  IKCryptoButtonView.swift
//  FBSnapshotTestCase
//
//  Created by InKwon on 20/11/2018.
//

import UIKit

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
    
    self.initFromNibName()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    self.initFromNibName()
  }
  
  private func initFromNibName(){
    let name = String(describing: type(of: self))
    let nib = UINib(nibName: name, bundle: Bundle(for: IKCryptoButton.self))
    nib.instantiate(withOwner: self, options: nil)
    
    self.contentView.layer.cornerRadius = 5.0
    self.addSubview(self.contentView)
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
    self.setColor()
  }
  
  private func setColor(){
    self.contentView.backgroundColor = configure.color.defaultKey
    self.bigKey.textColor = configure.color.defaultKeyTextColor
    self.mainKeyLabel.textColor = configure.color.defaultKeyTextColor
    self.subKeyLabel.textColor = configure.color.defaultKeyTextColor
  }
  
}

extension IKCryptoButton {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.isTouch = true
    self.contentView.backgroundColor = configure.color.touchedKey
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touchedKey = self.keySet.mainKey
    
    delegate?.touchedKey(key: touchedKey!)
    
    if self.isTouch {
      self.isTouch = false
      self.contentView.backgroundColor = configure.color.defaultKey
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self.isTouch {
      self.isTouch = false;
      self.contentView.backgroundColor = configure.color.defaultKey
    }
  }
  
}
