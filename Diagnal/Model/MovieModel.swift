//
//  MovieModel.swift
//  Diagnal
//
//  Created by Avinash Thakur on 01/07/23.
//

import Foundation

/// Movie Response Struct obtained from parsing json file
public struct MovieResponse: Codable {
    var page: MoviePage
}

public struct MoviePage: Codable {
    var title: String
    var totalContentItems: String
    var pageNum: String
    var pageSize: String
    var contentItems: MovieContent
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case contentItems = "content-items"
    }
}

public struct MovieContent: Codable {
    var content: [Movie]
}

public struct Movie: Codable {
    var name: String
    var posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case posterImage = "poster-image"
    }
}
