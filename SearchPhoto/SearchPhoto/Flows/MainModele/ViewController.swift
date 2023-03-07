//
//  ViewController.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 07.03.2023.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let fontSize: CGFloat = 16
    }

    // MARK: - Properties

    var searchController = UISearchController(searchResultsController: nil)

    // MARK: - IBOutlets

    @IBOutlet private weak var searchCollectionView: UICollectionView!
    @IBOutlet private weak var searchStackView: UIStackView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        self.hideKeyboard()
    }

}

// MARK: - Private Methods

private extension ViewController {

    func configureAppearance() {
        configureBackground()
        configureTextField()
        configureButton()
        configureCollectionView()
    }

    func configureBackground() {
        view.backgroundColor = .red
    }

    func configureTextField() {
        let searchImage = UIImage(named: "searchIcon")
        addLeftImageTo(textField: searchTextField, andImage: searchImage!)

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = AssetColor.gray
        searchTextField.layer.cornerRadius = Constants.cornerRadius
        searchTextField.layer.masksToBounds = true
        searchTextField.borderStyle = .none
        searchTextField.font = UIFont.systemFont(ofSize: 16)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // configure placeholder for textField
        let placeholderText = "Телефоны, яблоки, груши..."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.fontSize),
            .foregroundColor: AssetColor.grayText
        ]
        let attributedPlaceholderText = NSAttributedString(string: placeholderText, attributes: attributes)
        searchTextField.attributedPlaceholder = attributedPlaceholderText
    }

    func configureButton() {
        searchButton.backgroundColor = AssetColor.red
        searchButton.tintColor = AssetColor.white
        searchButton.layer.cornerRadius = Constants.cornerRadius
        searchButton.setTitle("Искать", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
    }

    func configureCollectionView() {
        searchCollectionView.backgroundColor = AssetColor.white
    }

    func addLeftImageTo(textField: UITextField, andImage image: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0,
                                                      y: 0.0,
                                                      width: image.size.width,
                                                      height: image.size.height)
        )
        leftImageView.image = image
        textField.leftView = leftImageView
        textField.leftViewMode = .always
    }

}

// MARK: - Actions

private extension ViewController {

    @objc func textFieldDidChange(_ textField: UITextField) {
        let hasText = textField.text?.isEmpty == false
        UIView.animate(withDuration: 0.4) {
            self.topConstraint.constant = hasText ? 20 : 12
            self.view.layoutIfNeeded()
        }
    }

}
