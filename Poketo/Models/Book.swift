//
//  Book.swift
//  Poketo
//
//  Created by Marco Francisco on 09/06/2025.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    var name: String
    var image: String = Asset.DefaultImages.defaultBookImage
    let read: Float = 0
}
