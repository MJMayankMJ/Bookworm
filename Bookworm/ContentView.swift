//
//  ContentView.swift
//  Bookworm
//
//  Created by Mayank Jangid on 10/20/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(books){ book in
                    NavigationLink(value: book) {
                        HStack{
                            EmojeRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Book.self, destination: { book in
                DetailView(book: book)
            })
            .navigationTitle("BookWorm")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddBookView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBookView) {
                AddBookView()
            }
        }
    }
}

#Preview { 
    ContentView()
}
