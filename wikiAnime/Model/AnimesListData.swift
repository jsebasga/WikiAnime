//
//  SerieData.swift
//  wikiAnime
//
//  Created by Sebastian Güiza 2/11/22.
//

import Foundation

struct AnimesListData: Codable {
    
    let data: [Anime]
}

struct Anime: Codable {
    
    let id: String?
    let type: String?
    let attributes: Attributes?
    
}

struct Attributes: Codable {
    
    let titles: Title?
    let posterImage: PosterImage?
}

struct Title: Codable {
    
    let englishName: String?
    let japaneseName: String?
    let kanjiName: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "en"
        case japaneseName = "en_jp"
        case kanjiName = "ja_jp"
    }
}

struct PosterImage: Codable {
    
    let tiny: String?
}
