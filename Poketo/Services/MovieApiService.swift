//
//  GoogleBooksApiService.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import Foundation

class MovieApiService {
    static let shared = MovieApiService()
    
    func searchmovieByTitle(query: String) async throws -> OpenLibraryResponse {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://openlibrary.org/search.json?limit=10&q=\(encodedQuery)") else {
            throw URLError(.badURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
            return response
        } catch {
            print("❌ JSON decoding failed:", error)
            throw error
        }
    }
}
