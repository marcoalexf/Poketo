//
//  BookTracker.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import SwiftUI

struct BookTracker : View {
    @Binding var books: [OpenLibraryBook]
    
    @State private var isShowingEdit = false
    @State private var selectedBook: OpenLibraryBook?
    
    func binding(for book: OpenLibraryBook) -> Binding<OpenLibraryBook> {
        guard let index = books.firstIndex(where: { $0.id == book.id }) else {
            fatalError("Book not found")
        }
        return $books[index]
    }
    
    var body: some View {
            NavigationStack {
                List(books) { book in
                    HStack {
                        AsyncImage(url: book.coverURL()) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .clipped()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Spacer()
                        
                        Text(book.title)
                        
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
                        Text("Edit")
                    }
                }
                .navigationTitle("Books")
            }
        }
}


#Preview {
    BookTracker(books: .constant([
        OpenLibraryBook(
            coverId: 11888471,
            hasFullText: true,
            editionCount: 5,
            title: "Sample Book",
            authorNames: ["Sample Author"],
            firstPublishYear: 2025,
            key: "/works/sample",
            ia: nil,
            authorKeys: nil,
            publicScan: false
        )
    ]))
}

