//
//  Post.swift
//  Networking
//
//  Created by Dmitry Suprun on 23.05.2022.
//

import Foundation

class Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(userId: Int, title: String, body: String) {
        self.title = title
        self.body = body
        self.userId = userId
        self.id = 101
    }
    
}
