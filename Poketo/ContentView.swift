//
//  ContentView.swift
//  Poketo
//
//  Created by Marco Francisco on 06/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var booksModel = OpenLibraryBookViewModel()
    
    @State private var selection = 0
    
    @State private var booksSearchText = ""
    @State private var moviesSearchText = ""
    @State private var seriesSearchText = ""

    
    var body: some View {
        TabView {
            NavigationStack {
                if booksModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = booksModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    BookTracker(books: $booksModel.books)
                    .navigationTitle("Books")
                    .searchable(text: $booksSearchText, prompt: "Search Books")
                    .onChange(of: booksSearchText) { oldValue, newValue in
                        print("Books search text: \(newValue)")                    }
                }
            }
            .task {
                //await booksModel.seachBooksByTitle(title: "Uzumaki")
            }
            .tag(0)
            .tabItem {
                Label("Books", systemImage: "book")
            }
            
            NavigationStack {
                List {
                    HStack {
                        Text("Movies List")
                    }
                }
                .navigationTitle("Movies")
                .searchable(text: $moviesSearchText, prompt: "Search Movies")
                .onChange(of: moviesSearchText) { oldValue, newValue in
                    print("Movies search text: \(newValue)")
                    // For now, no filtering
                }
                
            }
            .tag(1)
            .tabItem {
                Label("Movies", systemImage: "film")
            }
            
            NavigationStack {
                List {
                    VStack {
                        Text("Series List")
                    }
                }
                .navigationTitle("Series")
                .searchable(text: $seriesSearchText, prompt: "Search Series")
                .onChange(of: seriesSearchText) { oldValue, newValue in
                    print("Series search text: \(newValue)")
                    // For now, no filtering
                }
            }
            .tag(2)
            .tabItem {
                Label("Series", systemImage: "film")
            }
        }
#if os(iOS)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
#endif
    }
    
}

#Preview {
    ContentView()
}
