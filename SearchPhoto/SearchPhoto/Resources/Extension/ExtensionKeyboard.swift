//
//  ExtensionKeyboard.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Public Methods

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    // MARK: - Actions

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
