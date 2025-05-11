//
//  BookListViewModel.swift
//  Lab4
//
//  Created by mpate125 on 2/27/25.
//

import SwiftUI

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var currentIndex: Int = 0
    
    var currentBook: Book? {
        guard currentIndex >= 0 && currentIndex < books.count else { return nil }
        return books[currentIndex]
    }
    
    func addBook(title: String, author: String, genre: String, price: Double) {
        let newBook = Book(title: title, author: author, genre: genre, price: price)
        books.append(newBook)
        currentIndex = books.count - 1
    }
    
    func deleteBook(title: String) -> Bool {
        guard let idx = books.firstIndex(where: { $0.title == title }) else { return false }
        books.remove(at: idx)
        if currentIndex >= books.count {
            currentIndex = books.count - 1
        }
        return true
    }
    
    func searchBook(searchTerm: String) -> Book? {
        let found = books.first { $0.title == searchTerm || $0.genre == searchTerm }
        if let book = found, let idx = books.firstIndex(of: book) {
            currentIndex = idx
        }
        return found
    }
    
    func editBook(_ book: Book, newTitle: String, newAuthor: String, newGenre: String, newPrice: Double) {
        guard let idx = books.firstIndex(of: book) else { return }
        books[idx].title  = newTitle
        books[idx].author = newAuthor
        books[idx].genre  = newGenre
        books[idx].price  = newPrice
    }
    
    func goNext() -> Bool {
        if currentIndex >= books.count - 1 { return false }
        currentIndex += 1
        return true
    }
    
    func goPrevious() -> Bool {
        if currentIndex <= 0 { return false }
        currentIndex -= 1
        return true
    }
}

