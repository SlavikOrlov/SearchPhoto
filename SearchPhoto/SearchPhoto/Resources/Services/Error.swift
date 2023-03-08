//
//  Error.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

 enum CustomError: Error {
     case badUrl
     case decodeJSON
     case receivedRequestingData
     case unknownServerError
 }
