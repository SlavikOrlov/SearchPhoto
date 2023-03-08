//
//  ImageModel.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

struct ImageModel: Codable {

    let imageResults: [ImagesResult]
    
    enum CodingKeys: String, CodingKey {
        case imageResults = "results"
        case total = "total"
        case totalPages = "total_pages"
    }

}

struct ImagesResult: Codable {

    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let description: String
    let alt_description: String

}
