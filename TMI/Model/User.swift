//
//  TMI.swift
//  TMI
//
//  Created by Jason on 2021/11/09.
//

import Foundation
import UIKit

struct User {
    var id : String
    var pw : String
    var profileImg : UIImage
    var name : String
    var age : Int
    var job : String
    var contact : String
    var WrittenTMIs : [TMI]
    var FOLLOWERs : [User]
    var FOLLOWINGs : [User]
}

struct properties:Codable {
    let nickname : String
    let profile_image : String
    let thumbnail_image : String
    
    enum CodingKeys: String, CodingKey {
    case nickname
    case profile_image
    case thumbnail_image
    }
}

struct UserResponse:Codable{
    let id:Int
    let connected_at : String
    let properties : properties
    
    enum CodingKeys: String, CodingKey {
    case id
    case connected_at
    case properties
    }
}


