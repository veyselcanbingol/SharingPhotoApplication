//
//  Post.swift
//  SharingPhotoApplication
//
//  Created by Veysel Can Bingöl on 1.06.2022.
//

import Foundation


class Post {
    var email : String
    var comment : String
    var imageUrl : String
    
    init(email: String, comment: String, imageUrl :String ){
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
}
