//
//  IKKeySet.swift
//  IKCryptoKeyboard
//
//  Created by InKwon on 21/11/2018.
//

import Foundation

struct IKKeySet {
  let mainKey: String!
  let subKey: String!
  
  init(mainKey:String, subKey:String){
    self.mainKey = mainKey
    self.subKey = subKey
  }
  
  init(){
    mainKey = ""
    subKey = ""
  }
}
