//
//  CustomTextField.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 09.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    private let clearButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        clearButton.setImage(UIImage(named: "crossIcon"), for: .normal)
        clearButton.tintColor = .gray
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightFrame = super.rightViewRect(forBounds: bounds)
        rightFrame.origin.x -= 11
        return rightFrame
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var originalRect = super.leftViewRect(forBounds: bounds)
        originalRect.origin.x += 10
        originalRect.origin.y = (bounds.height - originalRect.height) / 2
        return originalRect
    }
    
    @objc private func clearText() {
        text = ""
    }
    
}
