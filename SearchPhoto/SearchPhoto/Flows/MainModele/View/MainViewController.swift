//
//  MainViewController.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 07.03.2023.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let fontSize: CGFloat = 16
        static let placeholderText: String = "Телефоны, яблоки, груши..."
        static let titleForSearchButton = "Искать"
        static let itemsPerRow: CGFloat = 3
        static let horizontalInset: CGFloat = 8
        static let insetDistanceView: CGFloat = 16
        static let spaceBetweenRows: CGFloat = 8
        static let cellProportion: Double = 130/100
        static let topPaddingForSearch: CGFloat = 24
        static let topPaddingBeforeSearch: CGFloat = 250
    }

    // MARK: - Properties

    private var image: ImageModel? = nil
    private var imageManager = ImageLoader()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - IBOutlets

    @IBOutlet private weak var searchCollectionView: UICollectionView!
    @IBOutlet private weak var searchStackView: UIStackView!
    @IBOutlet private weak var searchTextField: CustomTextField!
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

private extension MainViewController {

    func configureAppearance() {
        configureBackground()
        configureTextField()
        configureButton()
        configureCollectionView()
        configureaActivityIndicator()
    }

    func configureBackground() {
        view.backgroundColor = .white
    }

    func configureTextField() {
        let searchImage = UIImage(named: "searchIcon")
        addLeftImageTo(textField: searchTextField, andImage: searchImage!)

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = AssetColor.gray
        searchTextField.layer.cornerRadius = Constants.cornerRadius
        searchTextField.layer.masksToBounds = true
        searchTextField.borderStyle = .none
        searchTextField.font = UIFont.systemFont(ofSize: Constants.fontSize)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        let placeholderText = Constants.placeholderText
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
        searchButton.setTitle(Constants.titleForSearchButton, for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
    }

    func configureCollectionView() {
        searchCollectionView.backgroundColor = AssetColor.white
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(ImageCollectionViewCell.self,
                                      forCellWithReuseIdentifier: "ImageCell"
        )
        let layout = searchCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
    }

    func configureaActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
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

    func loadImages(query: String) {
        imageManager.loadImage(query: query) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                self?.searchCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - Actions

private extension MainViewController {

    @objc func textFieldDidChange(_ textField: UITextField) {
        let hasText = textField.text?.isEmpty == false
        UIView.animate(withDuration: 0.4) {
            self.topConstraint.constant = hasText ? Constants.topPaddingForSearch : Constants.topPaddingForSearch
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func tapSearchButton(_ sender: Any) {
        guard let query = searchTextField.text else {
            return
        }
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadImages(query: query)
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
                self.view.endEditing(true)
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        image?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageCell",
            for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let urlImage = image?.results[indexPath.item].urls.thumb
        cell.configure(urlImage: urlImage ?? "")
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.insetDistanceView * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / Constants.itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.insetDistanceView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: Constants.insetDistanceView,
            left: Constants.insetDistanceView,
            bottom: 0,
            right: Constants.insetDistanceView)
    }
    
}
