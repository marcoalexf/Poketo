//
//  ContentView.swift
//  Poketo
//
//  Created by Marco Francisco on 06/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var booksModel = OpenLibraryBookViewModel()
    @StateObject private var moviesModel = MovieViewModel()
    @StateObject private var seriesModel = MovieViewModel()
    
    @State private var selection = 0
    
    @State private var booksSearchText = ""
    @State private var moviesSearchText = ""
    @State private var seriesSearchText = ""
    
    @State private var showingAddBook = false
    @State private var showingAddSeries = false
    @State private var showingAddMovie = false
    
    var booksTab: some View {
        BookTrackerView(books: $booksModel.books)
            .searchable(text: $booksSearchText, prompt: "Search Books")
            .onChange(of: booksSearchText) { oldValue, newValue in
                print("Books search text: \(newValue)")
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddBook = true
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
    }
    
    var moviesTab: some View {
        MoviesTrackerView(movies: $moviesModel.movies)
            .searchable(text: $moviesSearchText, prompt: "Search Movies")
            .onChange(of: moviesSearchText) { oldValue, newValue in
                print("Movies search text: \(newValue)")
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddMovie = true
                    } label: {
                        Label("Track a movie", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMovie) {
                AddBookView()
            }
    }
    
    var seriesTab: some View {
        SeriesTrackerView(series: $seriesModel.movies)
            .searchable(text: $seriesSearchText, prompt: "Search Series")
            .onChange(of: seriesSearchText) { oldValue, newValue in
                print("Series search text: \(newValue)")
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingAddSeries = true
                    } label: {
                        Label("Track a series", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMovie) {
                AddBookView()
            }
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                if booksModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = booksModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    booksTab
                        .navigationTitle("Books")
                }
            }
            .tag(0)
            .tabItem {
                Label("Books", systemImage: "book")
            }
            
            NavigationStack {
                if moviesModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = moviesModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    moviesTab
                        .navigationTitle("Movies")
                }
            }
            .tag(1)
            .tabItem {
                Label("Movies", systemImage: "film")
            }
            
            NavigationStack {
                if seriesModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = seriesModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    seriesTab
                        .navigationTitle("Series")
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
