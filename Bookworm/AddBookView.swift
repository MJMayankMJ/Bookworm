//
//  AddBookView.swift
//  Bookworm
//
//  Created by Mayank Jangid on 10/20/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var showingAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's Name", text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section("Write a review"){
                    TextEditor(text: $review)
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6, id: \.self){
//                            Text("\($0)")
//                        }
//                    }
                    RatingView(rating: $rating)
                }
                Section{
                    Button("Save"){
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        if title.isEmpty || author.isEmpty || review.isEmpty {
                            showingAlert = true
                        } else {
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Complete the FUCKING FORM..... idiot", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
        }
    }
}

#Preview {
    AddBookView()
}
