//
//  ImageLoader.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

final class ImageLoader {

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - Internal Methods

    func loadImage(query: String,
                   response: @escaping (Result <ImageModel, Error>) -> Void) {
        networkService.request(query: query) { result in
            switch result {
            case .success (let data):
                do {
                    let images = try JSONDecoder().decode(ImageModel.self, from: data)
                    response(.success(images))
                } catch {
                    print(CustomError.decodeJSON)
                    response(.failure(error))
                }
            case .failure (let error):
                print(CustomError.receivedRequestingData)
                response(.failure(error))
            }
        }
    }

}
