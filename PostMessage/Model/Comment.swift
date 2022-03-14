//
//  Comment.swift
//  PostMessage
//
//  Created by Raúl Pavón on 11/03/22.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let body: String
    
    init() {
        self.postId = 0
        self.id = 0
        self.body = ""
    }
}
