//
//  BookTracker.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import SwiftUI

struct BookTracker : View {
    @Binding var books: [Book]
    
    @State private var isShowingEdit = false
    @State private var selectedBook: Book?
    
    func binding(for book: Book) -> Binding<Book> {
        guard let index = books.firstIndex(where: { $0.id == book.id }) else {
            fatalError("Book not found")
        }
        return $books[index]
    }
    
    var body: some View {
            NavigationStack {
                List(books) { book in
                    HStack {
                        Image(book.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                            .clipped()
                        
                        Spacer()
                        
                        Text(book.name)
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            var totalNumberOfPages = Int.random(in: 0...1000)
                            var totalNumberReadPages = Int.random(in: 0...totalNumberOfPages)
                            var progress = Double(totalNumberReadPages) / Double(totalNumberOfPages)
                            ProgressView(value: progress)
                                        .progressViewStyle(LinearProgressViewStyle())
                                        .frame(height: 8)
                                        .padding(.horizontal)
                                    
                                    Text("Page \(totalNumberReadPages) of \(totalNumberOfPages)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                        
                        
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button() {
                            selectedBook = book
                            isShowingEdit = true
                        } label: {
                            Label("Edit", systemImage: "square.and.arrow.up")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button() {
                            print("complete anime")
                        } label: {
                            Label("Complete", systemImage: "checkmark.circle.fill")
                        }
                        .tint(.green)
                    }
                }
                .navigationDestination(isPresented: $isShowingEdit) {
                    if let selectedBook = selectedBook {
                        EditBookView(book: binding(for: selectedBook))
                    }
                }
                .navigationTitle("Books")
            }
        }
}


#Preview {
    BookTracker(books: .constant([Book(name: "Sample Book")]))
}
