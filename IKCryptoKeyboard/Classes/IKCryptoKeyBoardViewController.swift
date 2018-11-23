//
//  IKCryptoKeyBoardViewController.swift
//  FBSnapshotTestCase
//
//  Created by InKwon on 07/11/2018.
//

import UIKit
import CryptoSwift

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
    public var firstLine: String
    public var secondLine: String
    public var thirdLine : String
    
    public init(firstLine: String, secondLine: String, thirdLine: String){
      self.firstLine = firstLine
      self.secondLine = secondLine
      self.thirdLine = thirdLine
    }
    
  }
  
  public enum IKCipherTypes {
    case aes
    case custom
  }
  
  public struct IKCipher {
    public var key: Array<UInt8> = "aaaaaaaaaaaaaaaa".bytes
    public var iv: Array<UInt8> = "aaaaaaaaaaaaaaaa".bytes
    public var type: IKCipherTypes = .aes
    
    public init (){
    }
  }
  
  public var isUseSubKeys = true
  public var titleName = "CryptoKeyBoard"
  public var informationText = "This is Crypto Keyboard ViewController"
  public var cancelButtonName = "Close"
  
  public var numberQwerty = "1234567890"
  
  public var specialsQwerty = "!@#$%^&*()-=\\`_+|~[];',./{}:\"<>?"
  
  public var mainQwerty = Qwerty(firstLine: "qwertyuiop",
                                 secondLine: "asdfghjkl",
                                 thirdLine: "zxcvbnm")
  
  public var subQwerty = Qwerty(firstLine: "ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ",
                                secondLine: "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ",
                                thirdLine: "ㅋㅌㅊㅍㅠㅜㅡ")
  
  public var shiftMainQwerty = Qwerty(firstLine: "QWERTYUIOP",
                                      secondLine: "ASDFGHJKL",
                                      thirdLine: "ZXCVBNM")
  
  public var shiftSubQwerty = Qwerty(firstLine: "ㅃㅉㄸㄲㅆㅛㅕㅑㅒㅖ",
                                     secondLine: "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ",
                                     thirdLine: "ㅋㅌㅊㅍㅠㅜㅡ")

  public lazy var numberLineCount = self.numberQwerty.count
  public lazy var firstLineCount = self.mainQwerty.firstLine.count
  public lazy var secondLineCount = self.mainQwerty.secondLine.count
  public lazy var thirdLineCount = self.mainQwerty.thirdLine.count

  public var color = Color()
  public var cipher = IKCipher()
  
  public var numberLineBlankPositons = [Int]()
  public var firstLineBlankPositons = [Int]()
  public var secondLineBlankPositons = [Int]()
  public var thirdLineBlankPositons = [Int]()
  
  
  
  public init(){
    
  }
}

public protocol IKCryptoKeyBoardViewControllerDelegate: class {
  func doEncrypt(plain: String) -> Array<UInt8>
  func doDecrypt(encrypted: Array<UInt8>) -> Array<UInt8>
  func didEncrypted(plain: String, encryptedData: Array<UInt8>)
  func didDecrypted(encryptedData: Array<UInt8>)
}

extension IKCryptoKeyBoardViewControllerDelegate {
  public func doEncrypt(plain: String) -> Array<UInt8> {
    /**
     * if you selected configure.cipher.type.custom, then you have to describe encrypt algorithm
     */
    return [UInt8]()
  }
  
  public func doDecrypt(encrypted: Array<UInt8>) -> Array<UInt8> {
    /**
     * this function is debug mode.
     *
     * if you selected configure.cipher.type.custom, then you have to describe decrypt algorithm
     */
    return [UInt8]()
  }
  
  public func didDecrypted(encryptedData: Array<UInt8>) {
    /**
     * this function is debug mode.
     */
  }
}

public class IKCryptoKeyBoardViewController: UIViewController {
  @IBOutlet fileprivate weak var navigationBar :UINavigationBar!
  
  @IBOutlet fileprivate weak var cryptoKeyboardView: IKCryptoKeyboardView!
  
  @IBOutlet fileprivate weak var passwordTextField: UITextField!
  
  @IBOutlet fileprivate weak var informationLabel: UILabel!
  
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
    self.informationLabel.text = configure.informationText
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
    self.passwordTextField.text = keys
  }
  
  func comfirmTouch(plain: String) {
    do {
      switch configure.cipher.type {
      case .aes:
        let encrypted = try AES(key: configure.cipher.key, blockMode: CBC(iv: configure.cipher.iv), padding: .pkcs7)
          .encrypt(plain.bytes)
        
        let replacePlain = plain.map{ _ in "a" }.joined()
        
        self.delegate?.didEncrypted(plain: replacePlain, encryptedData: encrypted)
        
        let decrypted = try AES(key: configure.cipher.key, blockMode: CBC(iv: configure.cipher.key), padding: .pkcs7).decrypt(encrypted)
        self.delegate?.didDecrypted(encryptedData: decrypted)
        
        self.dismiss(animated: true)

      case .custom:
        if let encrypted = self.delegate?.doEncrypt(plain: plain){
          let replacePlain = plain.map{ _ in "a" }.joined()
          
          self.delegate?.didEncrypted(plain: replacePlain, encryptedData: encrypted)
          
          if let decrypted = self.delegate?.doDecrypt(encrypted: encrypted) {
            self.delegate?.didDecrypted(encryptedData: decrypted)
          }
          
          self.dismiss(animated: true)
        }
      }
      
    } catch { }
  }
}
