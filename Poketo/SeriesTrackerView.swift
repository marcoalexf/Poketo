//
//  SeriesTrackerView.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import SwiftUI

struct SeriesTrackerView: View {
    @Binding var series: [OpenLibraryBook]
    
    @State private var isShowingEdit = false
    @State private var selectedSeries: OpenLibraryBook?
    
    func binding(for show: OpenLibraryBook) -> Binding<OpenLibraryBook> {
        guard let index = series.firstIndex(where: { $0.id == show.id }) else {
            fatalError("Movie not found")
        }
        return $series[index]
    }
    
    var body: some View {
        List(series) { show in
            HStack {
                AsyncImage(url: show.coverURL()) { phase in
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
                
                Text(show.title)
                
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
                    selectedSeries = show
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
    }
}
