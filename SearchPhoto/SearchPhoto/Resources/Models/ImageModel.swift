//
//  ImageModel.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 08.03.2023.
//

import Foundation

struct ImageModel: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable {
    let id: String
    let urls: URLs
    let user: User
    
    struct URLs: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
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
