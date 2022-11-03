//
//  SerieData.swift
//  wikiAnime
//
//  Created by Sebastian Güiza 2/11/22.
//

import Foundation

struct AnimeData: Codable{
    
    let data: [SerieData]
}

struct SerieData: Codable {
    
    let id: String?
    let type: String?
    let attributes: Attributes?
    
}

struct Attributes: Codable{
    
    let titles:Title?
    let posterImage: PosterImage?
}

struct Title: Codable {
    
    let en: String?
    let en_jp: String?
    let ja_jp: String?
}

struct PosterImage: Codable {
    
    let tiny: String?
}
