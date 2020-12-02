//
//  Photo.swift
//  Internews
//
//  Created by Evgeny Yagrushkin on 2020-12-01.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
