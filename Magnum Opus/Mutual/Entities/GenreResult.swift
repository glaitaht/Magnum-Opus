//
//  GenreResult.swift
//  Magnum Opus
//
//  Created by Cem Kılıç on 27.04.2022.
//

import Foundation
struct GenreResult: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}
