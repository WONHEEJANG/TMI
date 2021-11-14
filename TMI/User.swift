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
