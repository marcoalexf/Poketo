//
//  ContentView.swift
//  Poketo
//
//  Created by Marco Francisco on 06/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var booksModel = OpenLibraryBookViewModel()
    
    var body: some View {
      NavigationStack {
          if booksModel.isLoading {
              ProgressView("Loading...")
          } else if let error = booksModel.errorMessage {
              Text(error)
                  .foregroundColor(.red)
          } else {
              BookTracker(books: $booksModel.books)
          }
        }
      .task {
          await booksModel.seachBooksByTitle(title: "Uzumaki")
      }
    }
    
}

#Preview {
    ContentView()
}
