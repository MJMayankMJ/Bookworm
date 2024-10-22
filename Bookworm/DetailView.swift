//
//  DetailView.swift
//  Bookworm
//
//  Created by Mayank Jangid on 10/22/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 8))
                Text(book.genre)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .padding(8)
                    .background(.black.opacity(0.50))
                    .clipShape(.rect(cornerRadius: 18))
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Killing", author: "MJ", genre: "Fantasy", review: "Fucking Amazing", rating: 5)
        //trying to maked a SwiftDataModel like Book (here) without config or container will result if ur code crash ..... so dont try it without .modelContainer(container) down there....
        return DetailView(book: example)
            .modelContainer(container)
    } catch{
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
