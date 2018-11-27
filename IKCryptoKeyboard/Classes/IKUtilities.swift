//
//  IKUtilities.swift
//  IKCryptoKeyboard
//
//  Created by InKwon on 27/11/2018.
//

import Foundation
import AudioToolbox

open class IKUtilities {
  @available(iOS 10.0, *)
  private static let impactHaptic = UIImpactFeedbackGenerator()
  
  static func OccurHaptic(){
    if #available(iOS 10.0, *) {
      impactHaptic.impactOccurred()
    } else {
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
  }
}
