//
//  NetworkService.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

 final class NetworkService {

     // MARK: - Constants

     private enum Constants {
         static let endpoint: String = "/search/photos"
         static let apiKey: String = "Ip0XA55zY7b7-d19osq1L5btGg-YCeDZVpnnJjXqHxs"
     }

     // MARK: - Internal Methods

     func request(query: String,
                  complition: @escaping ((Result <Data, Error>) -> Void)) {
         var parameters = URLComponents(string: Urls.base)!
         parameters.path = Constants.endpoint
         parameters.queryItems = [
             URLQueryItem(name: "client_id", value: Constants.apiKey),
             URLQueryItem(name: "query", value: "show")
         ]

         guard let url = parameters.url else {
             return
         }
         URLSession.shared.dataTask(with: url) { data, response, error in
             DispatchQueue.main.async {
                 if let error = error {
                     complition(.failure(error))
                     return
                 }
                 guard let data = data else {
                     return
                 }
                 complition(.success(data))
             }
         }.resume()
     }
 }
