//
//  Post.swift
//  PostMessage
//
//  Created by Raúl Pavón on 10/03/22.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init() {
        self.userId = 0
        self.id = 0
        self.title = ""
        self.body = ""
    }
}
