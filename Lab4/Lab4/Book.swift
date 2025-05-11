//
//  Book.swift
//  Lab4
//
//  Created by mpate125 on 2/27/25.
//

import Foundation

struct Book: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var author: String
    var genre: String
    var price: Double
}
