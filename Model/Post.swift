//
//  Post.swift
//  SubredditCodable
//
//  Created by Levi Linchenko on 04/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation


struct JSONDictionary: Decodable {
    let data: DataDictionary
    struct DataDictionary: Decodable {
        let children: [PostDictionary]
        struct PostDictionary: Decodable {
            
            let post: Post
            private enum CodingKeys: String, CodingKey {
                case post = "data"
            }
        }
    }
}

struct Post: Decodable{
    let title: String
    let thumbnailEndPoint: String
    let numberOfUpvotes: Int
    let numberOfComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case thumbnailEndPoint = "thumbnail"
        case numberOfUpvotes =  "ups"
        case numberOfComments = "num_comments"
    }
}
