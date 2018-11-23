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

## Author

leibniz55, leibniz55@naver.com

## License

IKCryptoKeyboard is available under the MIT license. See the LICENSE file for more info.
