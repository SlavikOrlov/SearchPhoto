//
//  ImageModel.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

struct ImageModel: Codable {
    
    let results: [UnsplashPhoto]
    
    //    enum CodingKeys: String, CodingKey {
    //        case imageResults = "results"
    //    }
    
}

struct UnsplashPhoto: Codable {
    let id: String
    let urls: URLs
    let user: User
    //     let created_at: String
    //     let updated_at: String
    //     let promoted_at: String
    //     let width: Int
    //     let height: Int
    //     let color: String
    //     let blur_hash: String
    //     let description: String
    //     let alt_description: String
    
    struct URLs: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let tumb: String
    }
    
    struct User: Codable {
        let name: String
        let username: String
        let profileImage: ProfileImage
        
        struct ProfileImage: Codable {
            let small: String
            let medium: String
            let large: String
        }
    }
}
