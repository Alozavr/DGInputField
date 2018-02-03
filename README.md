# DGInputField

Hi! This is a simple `UITextField` sublass that handles formatting, input validation and cursor position for you! 

# Installation
Just put `DGInputField` folder into your project!

# Usage
You can just make your textfield of `DGInputField` class in your storyboard or just create it programmatically
![](https://1.downloader.disk.yandex.ru/disk/cd42120924e30967b54c32b23dc87d9fe7b513bb54041f947efc4c03b2e6ed46/5a75a71b/m0kdPLcqPxFCbBOI0Q_ZdNta87kWAdaEX8ixyE8dAw7l26TRMAveY96DI3_J7yj1apqzssCOMqEtKB3Fi-dZ4Q%3D%3D?uid=0&filename=Screen%20Shot%202018-02-03%20at%2011.10.45.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&fsize=135929&hid=2ba76a05ae73c7a78b656b480a9f2c82&media_type=image&tknv=v2&etag=4d1b9bcf8a294ba06d40750c8a71c8e6)

`DGInputField` takes delegation of `UITextField` that's why you should not override `delegate` property. Another delegate is provided: 
```swift
public protocol DGInputFieldDelegate: UITextFieldDelegate {
    func textDidChange(in textField: DGInputField, formattedText: String, unformattedText: String)
}
```
If you do not specify formatter, then `formattedText` will be equal to `unformattedText`

# Formatting

To add formatting for your input you should implement `StringFormatterProtocol` :
```swift
public protocol StringFormatterProtocol {
    func format(_ string: String) -> String
    func removeFormat(_ string: String) -> String
}
```
You can look an example in demo project. There is `CardNumberFormatter` to format input in groups of 4
# Validating

For now validation is made to prevent incorrect input. Perhaps it will be reworked in future. Just like formatting to support validation you just implement protocol `InputStringValidatorProtocol`:
```swift
public protocol InputStringValidatorProtocol {
    func isValid(string: String) -> Bool
}
```
If you set both formatter and validator, format is removed before checking string validation.

# Setup

To set `DGInputField` configuration use `TextFieldConfiguration` like in example: 
```swift
let configuration = TextFieldConfiguration(
            formatter: CardNumberFormatter(),
            validator: CardNumberInputValidator())
        creditCardField.setConfiguration(configuration)
```
Thats it!

# Licensing
This repository's code is distributed under **MIT** license.
