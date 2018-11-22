//
//  IKKeys.swift
//  IKCryptoKeyboard
//
//  Created by InKwon on 22/11/2018.
//

import Foundation

struct IKKeys {
  
  typealias tupleOfKey = (String,String)
  
  var numberLine = [String]()
  var firstLine = [tupleOfKey]()
  var secondLine = [tupleOfKey]()
  var thirdLine = [tupleOfKey]()
  var configure: IKCryptoKeyBoardConfigure
  
  init(configure: IKCryptoKeyBoardConfigure, type: IKKeyboardTypes){
    self.configure = configure
    
    switch type {
    case .main:
      self.setMainKeys()
    case .shift:
      self.setShiftKeys()
    case .special:
      self.setSpecialKeys()
    }
  }
  
  private mutating func setMainKeys(){
    numberLine = Array(configure.numberQwerty).map{ String($0) }
    
    if configure.isUseSubKeys{
      firstLine = Array(Zip2Sequence(_sequence1: Array(configure.mainQwerty.firstLine).map{String($0)},
                                     _sequence2: Array(configure.subQwerty.firstLine).map{String($0)}))
      secondLine = Array(Zip2Sequence(_sequence1: Array(configure.mainQwerty.secondLine).map{String($0)},
                                      _sequence2: Array(configure.subQwerty.secondLine).map{String($0)}))
      thirdLine = Array(Zip2Sequence(_sequence1: Array(configure.mainQwerty.thirdLine).map{String($0)},
                                     _sequence2: Array(configure.subQwerty.thirdLine).map{String($0)}))
    } else {
      firstLine = Array(configure.mainQwerty.firstLine).map{String($0)}.compactMap{ ($0, "") }
      secondLine = Array(configure.mainQwerty.secondLine).map{String($0)}.compactMap{ ($0, "") }
      thirdLine = Array(configure.mainQwerty.thirdLine).map{String($0)}.compactMap{ ($0, "") }
    }
  }
  
  private mutating func setShiftKeys(){
    numberLine = Array(configure.numberQwerty).map{ String($0) }
    
    if configure.isUseSubKeys {
      firstLine = Array(Zip2Sequence(_sequence1: Array(configure.shiftMainQwerty.firstLine).map{String($0)},
                                     _sequence2: Array(configure.shiftSubQwerty.firstLine).map{String($0)}))
      secondLine = Array(Zip2Sequence(_sequence1: Array(configure.shiftMainQwerty.secondLine).map{String($0)},
                                      _sequence2: Array(configure.shiftSubQwerty.secondLine).map{String($0)}))
      thirdLine = Array(Zip2Sequence(_sequence1: Array(configure.shiftMainQwerty.thirdLine).map{String($0)},
                                     _sequence2: Array(configure.shiftSubQwerty.thirdLine).map{String($0)}))
    } else {
      firstLine = Array(configure.shiftMainQwerty.firstLine).map{String($0)}.compactMap{ ($0, "") }
      secondLine = Array(configure.shiftMainQwerty.secondLine).map{String($0)}.compactMap{ ($0, "") }
      thirdLine = Array(configure.shiftMainQwerty.thirdLine).map{String($0)}.compactMap{ ($0, "") }
    }
  }
  
  private mutating func setSpecialKeys(){    
    var specialsQwerty = Array(configure.specialsQwerty).map{ String($0) }
    
    let numberSplit = specialsQwerty[0..<10]
    let firstSplit = specialsQwerty[10..<19]
    let secondSplit = specialsQwerty[19..<26]
    let thirdSplit = specialsQwerty[26..<specialsQwerty.count]
    
    let mainFirst = Array(firstSplit)
    let mainSecond = Array(secondSplit)
    let mainThird = Array(thirdSplit)
    
    numberLine = Array(numberSplit)
    firstLine = mainFirst.compactMap{ ($0, "") }
    secondLine = mainSecond.compactMap{ ($0, "") }
    thirdLine = mainThird.compactMap{ ($0, "") }
  }
  
}
