//
//  OpenLibraryBookViewModel.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movies: [OpenLibraryBook] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func seachBooksByTitle(title: String) async {
        isLoading = true
        do {
            movies = try await OpenLibraryApiService.shared.searchBooksByName(query: title).books
        } catch {
            errorMessage = "Failed to load books: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
