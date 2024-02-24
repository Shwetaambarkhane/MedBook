//
//  BookDetails.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 23/02/24.
//

import Foundation

struct BookDetails: Codable {
    var author_key: [String]
    var title: String
    var author_name: [String]
    var ratings_average: Double
    var readinglog_count: Int
}
