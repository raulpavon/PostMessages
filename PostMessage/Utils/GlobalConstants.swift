//
//  GlobalConstants.swift
//  PostMessage
//
//  Created by Raúl Pavón on 13/03/22.
//

import Foundation

struct GlobalConstants {
    enum PostMessage {
        static let title = "Posts"
        enum LbDescriptionTitle {
            static let title = "Description"
        }
        enum LbUser {
            static let title = "User"
        }
        enum UserInfo {
            static let name = "Name"
            static let email = "Email"
            static let phone = "Phone"
            static let web = "Web"
        }
        enum TableViewHeader {
            static let title = "COMMENTS"
        }
        enum UserDefaults {
            static let favorites = "favorites"
        }
        enum SegmentedControl {
            static let segmentOne = "All"
            static let segmentTwo = "Favorites"
        }
        enum BtDelete {
            static let title = "Delete All"
        }
    }
    
    enum Images {
        static let arrow = "greaterthan"
        static let refresh = "arrow.clockwise"
        static let back = "chevron.backward"
        static let starFill = "star.fill"
        static let star = "star"
    }
}
