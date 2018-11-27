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
      if configure.numberLineBlankPositons.contains(numberKeyArray.count){
        let blankButton = makeBlankButton()
        numberKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: num, subKey: "")
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      numberKeyArray.append(button)
    }
    
    for (main,sub) in keys.firstLine {
      if configure.firstLineBlankPositons.contains(firstKeyArray.count){
        let blankButton = makeBlankButton()
        firstKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      firstKeyArray.append(button)
    }
    
    for (main,sub) in keys.secondLine {
      if configure.secondLineBlankPositons.contains(secondKeyArray.count){
        let blankButton = makeBlankButton()
        secondKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      secondKeyArray.append(button)
    }
    
    for (main,sub) in keys.thirdLine {
      if configure.thirdLineBlankPositons.contains(thirdKeyArray.count){
        let blankButton = makeBlankButton()
        thirdKeyArray.append(blankButton)
      }
      let keySet = IKKeySet(mainKey: main, subKey: sub)
      let button = IKCryptoButton()
      button.configure = configure
      button.setKeySet(keySet: keySet)
      thirdKeyArray.append(button)
    }
  }
  
  private mutating func makeBlankButton() -> IKCryptoButton {
    let blankKeySet = IKKeySet()
    let blankButton = IKCryptoButton()
    blankButton.configure = configure
    blankButton.isEnabled = false
    blankButton.setKeySet(keySet: blankKeySet)
    blankButton.contentView.backgroundColor = configure.color.keyboardBackground
    
    return blankButton
  }
  
}
