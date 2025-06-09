//
//  GoogleBookApiModels.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//
import Foundation

struct OpenLibraryBook: Decodable, Identifiable {
    var id: String { key }

    let coverId: Int?
    let hasFullText: Bool
    let editionCount: Int
    let title: String
    let authorNames: [String]?
    let firstPublishYear: Int?
    let key: String
    let ia: [String]?
    let authorKeys: [String]?
    let publicScan: Bool

    enum CodingKeys: String, CodingKey {
        case coverId = "cover_i"
        case hasFullText = "has_fulltext"
        case editionCount = "edition_count"
        case title
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
        case key
        case ia
        case authorKeys = "author_key"
        case publicScan = "public_scan_b"
    }
    
    func coverURL(size: String = "M") -> URL? {
            guard let coverId = coverId else { return nil }
            let urlString = "https://covers.openlibrary.org/b/id/\(coverId)-\(size).jpg"
            return URL(string: urlString)
    }
}

struct OpenLibraryResponse: Decodable {
    let numberOfDocuments: Int
    let start: Int
    let books: [OpenLibraryBook]
    
    enum CodingKeys: String, CodingKey {
        case numberOfDocuments = "num_found"
        case start
        case books = "docs"
    }
}
