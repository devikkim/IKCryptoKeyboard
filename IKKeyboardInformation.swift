//
//  IKKeyArrays.swift
//  IKCryptoKeyboard
//
//  Created by InKwon on 21/11/2018.
//

import Foundation

struct IKKeyboardInformation {
  
  var firstKeyArray = [IKCryptoButton]()
  var secondKeyArray = [IKCryptoButton]()
  var thirdKeyArray = [IKCryptoButton]()
  var numberKeyArray = [IKCryptoButton]()
  
  private let configure: IKCryptoKeyBoardConfigure!
  
  private let mainKeys: IKKeys!
  private let shiftKeys: IKKeys!
  private let specialKeys: IKKeys!
  
  init(configure: IKCryptoKeyBoardConfigure) {
    self.configure = configure
    
    mainKeys = IKKeys(configure: configure, type: .main)
    shiftKeys = IKKeys(configure: configure, type: .shift)
    specialKeys = IKKeys(configure: configure, type: .special)
  }
  
  mutating func setKeyFrom(type: IKKeyboardTypes){
    switch type {
    case .main:
      setMainKey(keys: mainKeys)
    case .shift:
      setMainKey(keys: shiftKeys)
    case .special:
      setMainKey(keys: specialKeys)
    }
  }
  
  private mutating func setMainKey(keys: IKKeys){
    for num in keys.numberLine {
      if configure.numberLineBlankPositons.contains(self.numberKeyArray.count){
        let blankKeySet = IKKeySet()
        let blankButton = IKCryptoButton()
        blankButton.configure = configure
        
        blankButton.setKeySet(keySet: blankKeySet)
        self.numberKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: num, subKey: "")
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      self.numberKeyArray.append(button)
    }
    
    for (main,sub) in keys.firstLine {
      if configure.firstLineBlankPositons.contains(self.firstKeyArray.count){
        let blankKeySet = IKKeySet()
        let blankButton = IKCryptoButton()
        blankButton.configure = configure
        
        blankButton.setKeySet(keySet: blankKeySet)
        self.firstKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      self.firstKeyArray.append(button)
    }
    
    for (main,sub) in keys.secondLine {
      if configure.secondLineBlankPositons.contains(self.secondKeyArray.count){
        let blankKeySet = IKKeySet()
        let blankButton = IKCryptoButton()
        blankButton.configure = configure
        
        blankButton.setKeySet(keySet: blankKeySet)
        self.secondKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      self.secondKeyArray.append(button)
    }
    
    for (main,sub) in keys.thirdLine {
      if configure.thirdLineBlankPositons.contains(self.thirdKeyArray.count){
        let blankKeySet = IKKeySet()
        let blankButton = IKCryptoButton()
        blankButton.configure = configure
        
        blankButton.setKeySet(keySet: blankKeySet)
        self.thirdKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      self.thirdKeyArray.append(button)
    }
  }
}
