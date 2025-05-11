//
//  ContentView.swift
//  Lab4
//
//  Created by mpate125 on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BookListViewModel()
    @State private var showAddSheet = false
    @State private var showEditSheet = false
    @State private var showSearchAlert = false
    @State private var showDeleteAlert = false
    @State private var showNotFoundAlert = false
    @State private var showBoundaryAlert = false
    @State private var boundaryMessage = ""
    @State private var searchTerm = ""
    @State private var deleteTitle = ""
    @State private var addTitle = ""
    @State private var addAuthor = ""
    @State private var addGenre = ""
    @State private var addPrice = ""
    @State private var foundBook: Book? = nil
    @State private var showFoundBookAlert = false
    @State private var editTitle = ""
    @State private var editAuthor = ""
    @State private var editGenre = ""
    @State private var editPrice = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                if let book = viewModel.currentBook {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue.opacity(0.1))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 180)
                        VStack(spacing: 8) {
                            Text("Title: \(book.title)").font(.title2).bold()
                            Text("Author: \(book.author)")
                            Text("Genre: \(book.genre)")
                            Text(String(format: "Price: $%.2f", book.price))
                        }
                        .padding()
                    }
                    .padding(.horizontal, 16)
                } else {
                    Text("No books in the list.")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .navigationTitle("My Book List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Search") {
                        searchTerm = ""
                        showSearchAlert = true
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Add") {
                        addTitle  = ""
                        addAuthor = ""
                        addGenre  = ""
                        addPrice  = ""
                        showAddSheet = true
                    }
                    Button("Delete") {
                        deleteTitle = ""
                        showDeleteAlert = true
                    }
                    Button("Edit") {
                        guard let current = viewModel.currentBook else { return }
                        editTitle  = current.title
                        editAuthor = current.author
                        editGenre  = current.genre
                        editPrice  = String(current.price)
                        showEditSheet = true
                    }
                    HStack(spacing: 16) {
                        Button("Previous") {
                            let success = viewModel.goPrevious()
                            if !success {
                                boundaryMessage = "You are at the beginning of the list."
                                showBoundaryAlert = true
                            }
                        }
                        Button("Next") {
                            let success = viewModel.goNext()
                            if !success {
                                boundaryMessage = "You are at the end of the list."
                                showBoundaryAlert = true
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Add New Book")) {
                            TextField("Title", text: $addTitle)
                            TextField("Author", text: $addAuthor)
                            TextField("Genre", text: $addGenre)
                            TextField("Price", text: $addPrice).keyboardType(.decimalPad)
                        }
                        Button("Save") {
                            guard !addTitle.isEmpty, let p = Double(addPrice) else { return }
                            viewModel.addBook(title: addTitle, author: addAuthor, genre: addGenre, price: p)
                            showAddSheet = false
                        }
                        Button("Cancel", role: .cancel) {
                            showAddSheet = false
                        }
                    }
                    .navigationTitle("New Book")
                }
            }
            .sheet(isPresented: $showEditSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Edit Book")) {
                            TextField("Title", text: $editTitle)
                            TextField("Author", text: $editAuthor)
                            TextField("Genre", text: $editGenre)
                            TextField("Price", text: $editPrice).keyboardType(.decimalPad)
                        }
                        Button("Update") {
                            guard let current = viewModel.currentBook, let p = Double(editPrice) else { return }
                            viewModel.editBook(current, newTitle: editTitle, newAuthor: editAuthor, newGenre: editGenre, newPrice: p)
                            showEditSheet = false
                        }
                        Button("Cancel", role: .cancel) {
                            showEditSheet = false
                        }
                    }
                    .navigationTitle("Edit Book")
                }
            }
            .alert("Search Book by Title or Genre", isPresented: $showSearchAlert, actions: {
                TextField("Enter search term", text: $searchTerm)
                Button("Search", action: doSearch)
                Button("Cancel", role: .cancel) {}
            })
            .alert("Delete Book by Title", isPresented: $showDeleteAlert, actions: {
                TextField("Enter title to delete", text: $deleteTitle)
                Button("Delete", action: doDelete)
                Button("Cancel", role: .cancel) {}
            })
            .alert("Not Found", isPresented: $showNotFoundAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("No matching book was found.")
            }
            .alert("Book Found", isPresented: $showFoundBookAlert, presenting: foundBook) { _ in
                Button("OK", role: .cancel) {}
            } message: { book in
                Text("""
                     Title:  \(book.title)
                     Author: \(book.author)
                     Genre:  \(book.genre)
                     Price:  $\(book.price)
                     """)
            }
            .alert("Note", isPresented: $showBoundaryAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(boundaryMessage)
            }
        }
    }
    
    private func doSearch() {
        if let book = viewModel.searchBook(searchTerm: searchTerm) {
            foundBook = book
            showFoundBookAlert = true
        } else {
            showNotFoundAlert = true
        }
    }
    
    private func doDelete() {
        let success = viewModel.deleteBook(title: deleteTitle)
        if !success {
            showNotFoundAlert = true
        }
    }
}

