//
//  AddBookView.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import SwiftUI

struct AddBookView: View {
    @State private var searchText = ""
    @State private var searchResults: [OpenLibraryBook] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        List {
            if isLoading {
                ProgressView()
            } else if let errorMessage = errorMessage {
                Text(errorMessage).foregroundColor(.red)
            } else {
                ForEach(searchResults) { book in
                    HStack {
                        Text(book.title)
                        Spacer()
                        Button("Add") {
                            print("Adding book")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { (oldValue, newValue) in
            Task {
                await performSearch(query: newValue)
            }
        }
        .navigationTitle("Add Books")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    print("Adding book")
                }
            }
        }
    }
    
    func performSearch(query: String) async {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Replace with your async fetch code
            try await Task.sleep(nanoseconds: 500_000_000)
            searchResults = []
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

