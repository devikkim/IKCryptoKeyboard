//
//  IKCryptoKeyBoardViewController.swift
//  FBSnapshotTestCase
//
//  Created by InKwon on 07/11/2018.
//

import UIKit

public struct IKCryptoKeyBoardConfigure {
  
  public struct Color {
    public var touchedButton = UIColor(red:0.20, green:0.39, blue:0.73, alpha:1.0)
    public var defaultButton = UIColor(red:0.00, green:0.19, blue:0.53, alpha:1.0)
    public var keyboardBackground = UIColor(red:0.00, green:0.19, blue:0.53, alpha:1.0)
    
    public var functionKeyTextColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
    public var keyTextColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
    
    public init () {
      
    }
  }
  
  public struct Qwerty {
    public var numberLine: String
    public var firstLine: String
    public var secondLine: String
    public var thirdLine : String
    
    public init(numberLine: String, firstLine: String, secondLine: String, thirdLine: String){
      self.numberLine = numberLine
      self.firstLine = firstLine
      self.secondLine = secondLine
      self.thirdLine = thirdLine
    }
    
  }
  
  public var isUseSubKeys = true
  
  public var titleName = "CryptoKeyBoard"
  public var cancelButtonName = "Close"
  
  public var numberQwerty = "1234567890"
  
  public var specialsQwerty = "!@#$%^&*()-=\\`_+|~[];',./{}:\"<>?"
  
  public var mainQwerty = Qwerty(numberLine: "1234567890",
                                 firstLine: "qwertyuiop",
                                 secondLine: "asdfghjkl",
                                 thirdLine: "zxcvbnm")
  
  public var subQwerty = Qwerty(numberLine: "1234567890",
                                firstLine: "ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ",
                                secondLine: "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ",
                                thirdLine: "ㅋㅌㅊㅍㅠㅜㅡ")
  
  public var shiftMainQwerty = Qwerty(numberLine: "1234567890",
                                      firstLine: "QWERTYUIOP",
                                      secondLine: "ASDFGHJKL",
                                      thirdLine: "ZXCVBNM")
  
  public var shiftSubQwerty = Qwerty(numberLine: "1234567890",
                                     firstLine: "ㅃㅉㄸㄲㅆㅛㅕㅑㅒㅖ",
                                     secondLine: "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ",
                                     thirdLine: "ㅋㅌㅊㅍㅠㅜㅡ")

  public lazy var numberLineCount = self.numberQwerty.count
  public lazy var firstLineCount = self.mainQwerty.firstLine.count
  public lazy var secondLineCount = self.mainQwerty.secondLine.count
  public lazy var thirdLineCount = self.mainQwerty.thirdLine.count

  public var color = Color()
  
  public var numberLineBlankPositons = [Int]()
  public var firstLineBlankPositons = [Int]()
  public var secondLineBlankPositons = [Int]()
  public var thirdLineBlankPositons = [Int]()
  
  public init(){
    
  }
}

public protocol IKCryptoKeyBoardViewControllerDelegate: class {
  func encrypted(plain: String, encryptedData: String)
}

public class IKCryptoKeyBoardViewController: UIViewController {
  @IBOutlet fileprivate weak var navigationBar :UINavigationBar!
  
  @IBOutlet fileprivate weak var cryptoKeyboardView: IKCryptoKeyboardView!
  
  @IBOutlet fileprivate weak var inputText: UITextField!
  
  public var configure = IKCryptoKeyBoardConfigure()
  
  public var delegate: IKCryptoKeyBoardViewControllerDelegate?
  
  private var cancelButton: UIBarButtonItem!
  
  public init() {
    super.init(nibName: "IKCryptoKeyBoardViewController", bundle: Bundle(for: IKCryptoKeyBoardViewController.self))
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBar.topItem?.title = self.configure.titleName
    self.cancelButton = UIBarButtonItem(title: self.configure.cancelButtonName,
                                        style: .plain,
                                        target: self,
                                        action: #selector(cancelAction))
    
    self.navigationBar.topItem?.leftBarButtonItem = self.cancelButton
    
    setCryptoKeyboard()
    
  }
  
  @objc func cancelAction () {
    self.dismiss(animated: true)
  }
  
  private func setCryptoKeyboard() {
    self.setBlankPostions()
    cryptoKeyboardView.configure = configure
    cryptoKeyboardView.setKeys(type: IKKeyboardTypes.main)
    
    cryptoKeyboardView.delegate = self
    
  }
  
  private func setBlankPostions() {
    configure.numberLineBlankPositons = setRandomPosition(limit: configure.numberLineCount)
    configure.firstLineBlankPositons = setRandomPosition(limit: configure.firstLineCount)
    configure.secondLineBlankPositons = setRandomPosition(limit: configure.secondLineCount)
    configure.thirdLineBlankPositons = setRandomPosition(limit: configure.thirdLineCount)
  }
  
  private func setRandomPosition(limit: Int) -> [Int] {
    var array = [Int]()
    
    while(array.count != 2){
      let random = Int.random(in: 0..<limit)
      
      if !array.contains(random) {
        array.append(random)
      }
    }
    
    return array
  }
  
}

extension IKCryptoKeyBoardViewController: UITextFieldDelegate {
  private func textFieldDidBeginEditing(_ textField: UITextField) {
    _ = textField.resignFirstResponder()
  }
}


extension IKCryptoKeyBoardViewController: IKCryptoKeyboardViewDelegate {
  func touched(keys:String) {
    self.inputText.text = keys
  }
  
  func comfirmTouch(encrypted:String) {
    if let plain = self.inputText.text {
      
      var data = ""
      for _ in 0..<plain.count{
        data += "a"
      }
      
      self.delegate?.encrypted(plain: data, encryptedData: encrypted)
      self.dismiss(animated: true)
    }
  }
}
