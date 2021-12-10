//
//  TMI.swift
//  TMI
//
//  Created by Jason on 2021/11/09.
//

import Foundation
import UIKit

class User {
    init() {
        self.id = ""
        self.profileImg = ""
        self.name = ""
        self.age = 99
        self.job = ""
        self.contact = ""
        self.topics = []
        self.pushTime = ""
        self.WrittenTMIs = []
        self.FOLLOWERs = []
        self.FOLLOWINGs = []
    }
    init(id:String, profileImg:String, name:String, age:Int, job :String, contact : String) {
        self.id = id
        self.profileImg = profileImg
        self.name = name
        self.age = age
        self.job = job
        self.contact = contact
        self.topics = []
        self.pushTime = ""
        self.WrittenTMIs = []
        self.FOLLOWERs = []
        self.FOLLOWINGs = []
    }
    var id : String
    var profileImg : String
    var name : String
    var age : Int
    var job : String
    var contact : String
    var topics : [String]
    var pushTime : String
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


