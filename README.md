# IKCryptoKeyboard

[![CI Status](https://img.shields.io/travis/leibniz55/IKCryptoKeyboard.svg?style=flat)](https://travis-ci.org/leibniz55/IKCryptoKeyboard)
[![Version](https://img.shields.io/cocoapods/v/IKCryptoKeyboard.svg?style=flat)](https://cocoapods.org/pods/IKCryptoKeyboard)
[![License](https://img.shields.io/cocoapods/l/IKCryptoKeyboard.svg?style=flat)](https://cocoapods.org/pods/IKCryptoKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/IKCryptoKeyboard.svg?style=flat)](https://cocoapods.org/pods/IKCryptoKeyboard)

## Demo
### English/Korea Keyboard
<img src="/Screenshots/IKCryptoKeyboard.gif" />

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 4.0
- ios 9.3

## Installation

IKCryptoKeyboard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IKCryptoKeyboard'
```

## How to use

``` swift

extension ViewController: UITextFieldDelegate{

  func textFieldDidBeginEditing(_ textField: UITextField) {
    _ = textField.resignFirstResponder()
    
    let vc = IKCryptoKeyBoardViewController()
    vc.delegate = self
    
    self.present(vc, animated: true)
  }
}

extension ViewController: IKCryptoKeyBoardViewControllerDelegate {
  // get encrypted data from IKCryptoKeyBoardViewController
  func didEncrypted(plain: String, encryptedData: Array<UInt8>) {
    self.pwTextField.text = plain
    self.encryptedTextField.text = encryptedData.toBase64()!
  }
  
  // for debug
  func didDecrypted(encryptedData: Array<UInt8>) {
    if let decrypted = String(bytes: encryptedData, encoding: .utf8){
      self.decryptedTextField.text = decrypted
    } else {
      self.decryptedTextField.text = encryptedData.toHexString()
    }
  }
}


```

## Customize

### Description
<img src="/Screenshots/IKCryptoKeyboard_Description.png" />


``` swift

let vc = IKCryptoKeyBoardViewController()
var configure = IKCryptoKeyBoardConfigure()
vc.configure = configure


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
  public var color = Color()
  public var cipher = IKCipher()
  ...
}

```

### Use Custom Cipher
if you want custom cipher encrypt & decrypt,

``` swift
let vc = IKCryptoKeyBoardViewController()
var configure = IKCryptoKeyBoardConfigure()
vc.configure.cipher.type = .custom // default is aes
vc.configure = configure

extension ViewController: IKCryptoKeyBoardViewControllerDelegate {
  func doEncrypt(plain: String) -> Array<UInt8> {
    // describe encrypt function
  }
  
  // for debug
  func doDecrypt(encrypted: Array<UInt8>) -> Array<UInt8> {
  
    // describe decrypt function
  }
}

```

## Author

leibniz55, leibniz55@naver.com

## License

IKCryptoKeyboard is available under the MIT license. See the LICENSE file for more info.
