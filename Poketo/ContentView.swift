//
//  ContentView.swift
//  Poketo
//
//  Created by Marco Francisco on 06/06/2025.
//

import SwiftUI

struct EditBookView: View {
    @Binding var book: Book
    
    var body: some View {
        Form {
            TextField("Name", text: $book.name)
            TextField("Image", text: $book.image)
        }
        .navigationTitle("Edit Book")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct ContentView: View {
    @State private var books = [
        Book(name: "Book 1"),
        Book(name: "Book 2"),
        Book(name: "Book 3")
    ]
    
    var body: some View {
      Text("Test")
    }
    
}


#Preview {
    ContentView()
}
