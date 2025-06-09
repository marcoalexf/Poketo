//
//  GoogleBooksApiService.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import Foundation

class OpenLibraryApiService {
    static let shared = OpenLibraryApiService()
    
    func searchBooksByName(query: String) async throws -> OpenLibraryResponse {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
    }
}
