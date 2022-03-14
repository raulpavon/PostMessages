//
//  User.swift
//  PostMessage
//
//  Created by Raúl Pavón on 11/03/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    
    init() {
        self.id = 0
        self.name = ""
        self.email = ""
        self.phone = ""
        self.website = ""
    }
}
