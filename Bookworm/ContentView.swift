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
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
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
                .onDelete(perform: deleteBook )
            }
            .navigationDestination(for: Book.self, destination: { book in
                DetailView(book: book)
            })
            .navigationTitle("BookWorm")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
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
    
    func deleteBook( at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview { 
    ContentView()
}
