//
//  DGInputField.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import UIKit

public struct TextFieldConfiguration {
    let formatter: StringFormatterProtocol?
    let validator: InputStringValidatorProtocol?
    
    public init(formatter: StringFormatterProtocol?, validator: InputStringValidatorProtocol?) {
        self.formatter = formatter
        self.validator = validator
    }
}

public protocol DGInputFieldDelegate: UITextFieldDelegate {
    func textDidChange(in textField: DGInputField, formattedText: String, unformattedText: String)
}

public class DGInputField: UITextField {
    
    var formatter: StringFormatterProtocol?
    var validator: InputStringValidatorProtocol?
    weak public var inputFieldDelegate: DGInputFieldDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setConfiguration(_ configuration: TextFieldConfiguration?) {
        formatter = configuration?.formatter
        validator = configuration?.validator
    }
    
    public func getUnformattedText() -> String {
        let currentText = text ?? ""
        guard let formatter = formatter else {
            return currentText
        }
        return formatter.removeFormat(currentText)
    }
    
    func commonInit() {
        setupFrameSize()
        setupDelegate()
        setupNotifications()
    }
    
    // MARK: Notification
    
    @objc func textFieldDidUpdate(_: DGInputField) {
        updateText(text)
    }
    
    @objc private func textFieldDidReturn(_: DGInputField) {
    }
    
    // MARK: - Setup
    
    func setupNotifications() {
        addTarget(self, action: #selector(textFieldDidUpdate), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidReturn), for: .editingDidEndOnExit)
    }
    
    func setupFrameSize() {
        let controlSize = frame.size
        let rect = CGRect(origin: frame.origin, size: controlSize)
        frame = rect
    }
    
    private func setupDelegate() {
        self.delegate = self
    }
    
    // MARK: Clear button
    
    override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.size.width - 30, y: bounds.origin.y + 2, width: 15, height: bounds.size.height)
    }
    
    // MARK: Private
    
    private func updateText(_ newValue: String?) {
        let newText = newValue ?? ""
        
        guard let formatter = formatter,
            let selectedRange = selectedTextRange else {
                text = newText
                inputFieldDelegate?.textDidChange(in: self,
                                                  formattedText: newText,
                                                  unformattedText: newText)
                return
        }
        
        let oldLength = newText.count
        let oldIdx = offset(from: beginningOfDocument, to: selectedRange.start)
        let formatted = formatter.format(newText)
        text = formatted
        inputFieldDelegate?.textDidChange(in: self,
                                          formattedText: formatted,
                                          unformattedText: formatter.removeFormat(formatted))
        
        let newIdx = max(0, formatted.count - oldLength + oldIdx)
        guard let position = position(from: beginningOfDocument, offset: newIdx) else { return }
        DispatchQueue.main.async {
            self.selectedTextRange = self.textRange(from: position, to: position)
        }
    }
}

extension DGInputField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let validator = validator,
            let currentText = text else {
                return true
        }
        
        var resultString = NSString(string: currentText).replacingCharacters(in: range, with: string) as String
        if let formatter = formatter {
            resultString = formatter.removeFormat(resultString)
        }
        return validator.isValid(string: resultString)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        inputFieldDelegate?.textDidChange(in: self,
                                          formattedText: "",
                                          unformattedText: "")
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
}
